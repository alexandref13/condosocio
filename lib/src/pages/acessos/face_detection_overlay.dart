import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';

class FaceDetectionOverlay extends StatefulWidget {
  const FaceDetectionOverlay({
    super.key,
    required this.cameras,
    this.cameraDirection = CameraLensDirection.front,
    this.overlay,
    required this.faceDetectorOptions,
    required this.resultCallback,
  });

  /// Câmera desejada (frontal por padrão).
  final CameraLensDirection cameraDirection;

  /// Widget sobreposto ao preview (mira/quadros/etc).
  final Widget? overlay;

  /// Câmeras disponíveis (via `availableCameras()`).
  final List<CameraDescription> cameras;

  /// Opções do detector de faces.
  final FaceDetectorOptions faceDetectorOptions;

  /// Callback com a lista de faces detectadas a cada frame.
  final void Function(List<Face> result) resultCallback;

  @override
  State<FaceDetectionOverlay> createState() => _FaceDetectionOverlayState();
}

class _FaceDetectionOverlayState extends State<FaceDetectionOverlay> {
  CameraController? _camController;
  FaceDetector? _faceDetector;

  int _cameraIndex = -1;
  bool _canProcess = true;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _selectCameraIndex();
    _faceDetector = FaceDetector(options: widget.faceDetectorOptions);
    _startCamera();
  }

  void _selectCameraIndex() {
    // Preferir a câmera com orientação 90° na direção pedida
    final candidates =
        widget.cameras.where((c) => c.lensDirection == widget.cameraDirection);

    final with90 = candidates.where((c) => c.sensorOrientation == 90).toList();
    if (with90.isNotEmpty) {
      _cameraIndex = widget.cameras.indexOf(with90.first);
      return;
    }

    // fallback: primeira câmera com a direção pedida
    for (var i = 0; i < widget.cameras.length; i++) {
      if (widget.cameras[i].lensDirection == widget.cameraDirection) {
        _cameraIndex = i;
        return;
      }
    }
    _cameraIndex = -1; // nenhuma câmera encontrada
  }

  Future<void> _startCamera() async {
    if (_cameraIndex < 0 || _cameraIndex >= widget.cameras.length) {
      if (kDebugMode) {
        print(
            'Nenhuma câmera compatível encontrada para ${widget.cameraDirection}.');
      }
      setState(() {});
      return;
    }

    final camera = widget.cameras[_cameraIndex];

    // ⬇️ ALTERAÇÃO 1: formato por plataforma (iOS = BGRA, Android = NV21)
    _camController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: defaultTargetPlatform == TargetPlatform.iOS
          ? ImageFormatGroup.bgra8888 // iOS: mais estável pro ML Kit
          : ImageFormatGroup.nv21, // Android: preferir NV21
    );

    try {
      await _camController!.initialize();
      if (!mounted) return;
      await _camController!.startImageStream(_imageProcess);
      setState(() {});
    } catch (e) {
      if (kDebugMode) print('Falha ao inicializar câmera: $e');
      await _stopCamera();
      if (mounted) setState(() {});
    }
  }

  Future<void> _imageProcess(CameraImage image) async {
    if (!_canProcess || _isBusy) return;

    // ⬇️ ALTERAÇÃO 2: bytes por formato (NV21 otimizado)
    late final Uint8List bytes;
    if (image.format.group == ImageFormatGroup.nv21) {
      // NV21 já vem no primeiro plano (Android)
      bytes = image.planes.first.bytes;
    } else {
      // BGRA8888 (iOS) ou YUV420: concatena planos
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      bytes = allBytes.done().buffer.asUint8List();
    }

    final Size size = Size(
      image.width.toDouble(),
      image.height.toDouble(),
    );

    // Rotação a partir da câmera selecionada
    final camera = widget.cameras[_cameraIndex];
    final rotation =
        InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (rotation == null) return;

    // Formato do frame
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return;

    // API nova: InputImageMetadata (um único bytesPerRow)
    final metadata = InputImageMetadata(
      size: size,
      rotation: rotation,
      format: format,
      bytesPerRow: image.planes.first.bytesPerRow,
    );

    final inputImage = InputImage.fromBytes(
      bytes: bytes,
      metadata: metadata,
    );

    await _detectionProcess(inputImage);
  }

  Future<void> _detectionProcess(InputImage inputImage) async {
    if (!_canProcess || _isBusy) return;
    _isBusy = true;

    try {
      final faces = await _faceDetector!.processImage(inputImage);

      // Com metadata válida, chamamos o callback
      if (inputImage.metadata?.size != null) {
        widget.resultCallback(faces);
      }
    } catch (e) {
      if (kDebugMode) print('Erro no processamento de face: $e');
    } finally {
      _isBusy = false;
      if (mounted) setState(() {});
    }
  }

  Widget _viewRender() {
    if (_cameraIndex == -1) {
      return const Center(
        child: Text(
          'Câmera não encontrada para a direção solicitada.',
          textAlign: TextAlign.center,
        ),
      );
    }

    final controller = _camController;
    if (controller == null || !controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * controller.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Transform.scale(
            scale: scale,
            child: Center(child: CameraPreview(controller)),
          ),
          if (widget.overlay != null) widget.overlay!,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _viewRender());
  }

  Future<void> _stopCamera() async {
    try {
      await _camController?.stopImageStream();
    } catch (_) {
      // pode lançar se a stream não estiver rodando; ignoramos
    }
    await _camController?.dispose();
    _camController = null;
  }

  @override
  void dispose() {
    _canProcess = false;
    _stopCamera();
    _faceDetector?.close();
    super.dispose();
  }
}
