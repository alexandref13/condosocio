import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

/// Faces detected in one camera frame, with every [Face.boundingBox] already
/// remapped into [imageSize]'s coordinate space — which is always
/// `Size(1, controller.value.aspectRatio)`, the same canonical portrait
/// aspect ratio the preview itself is rendered at (see `_viewRender`).
///
/// Each box is turned into a *fraction* of the upright frame ML Kit reported
/// it in, then scaled into [imageSize]. Working in fractions rather than
/// the buffer's own pixel dimensions means a caller's math never has to
/// assume the streamed buffer's resolution matches the preview's reported
/// resolution pixel-for-pixel — only that they share the same aspect ratio,
/// which holds because `camera_android` and `camera_avfoundation` both size
/// the image stream from the same preview configuration. This is what keeps
/// the on-screen oval and the detected face box in the same coordinate
/// system.
///
/// The upright frame differs per platform:
/// - **iOS**: `camera_avfoundation` sets `videoOrientation` on the
///   video-data-output connection, so AVFoundation already delivers the
///   buffer upright and ML Kit's boxes are in that same portrait frame
///   (verified on device).
/// - **Android**: `camera_android` streams the sensor's raw landscape
///   buffer and `InputImage.fromByteArray` is told the rotation needed to
///   make it upright; ML Kit then reports boxes in that rotated (upright)
///   frame, i.e. with width/height swapped for 90°/270°. No manual rotation
///   of the box is required — only knowing the swapped frame size.
class FaceFrameResult {
  const FaceFrameResult({
    required this.faces,
    required this.imageSize,
    required this.lensDirection,
  });

  /// Faces with [Face.boundingBox] already expressed in [imageSize] units.
  final List<Face> faces;

  /// The canonical portrait size the boxes in [faces] are expressed against
  /// — always `Size(1, controller.value.aspectRatio)`.
  final Size imageSize;

  final CameraLensDirection lensDirection;
}

class FaceDetectionOverlay extends StatefulWidget {
  const FaceDetectionOverlay(
      {super.key,
      required this.cameras,
      this.cameraDirection = CameraLensDirection.front,
      this.overlay,
      required this.faceDetectorOptions,
      required this.resultCallback});

  final CameraLensDirection cameraDirection;
  final Widget? overlay;
  final List<CameraDescription> cameras;
  final FaceDetectorOptions faceDetectorOptions;
  final void Function(FaceFrameResult result) resultCallback;

  @override
  State<FaceDetectionOverlay> createState() => FaceDetectionOverlayState();
}

class FaceDetectionOverlayState extends State<FaceDetectionOverlay> {
  // Caps the analysis rate so ML Kit never receives frames faster than it can
  // drain them; this is independent of `_isBusy`, which only protects against
  // a single slow frame overlapping the next one.
  static const _minProcessInterval = Duration(milliseconds: 90);

  /// Calibration switch, Android only: flips detected boxes horizontally.
  /// `camera_android` shows the front camera un-mirrored and streams frames
  /// the same way, so boxes should line up as-is (false). If on a real device
  /// "mova para a esquerda/direita" turns out inverted, set this to true.
  static const bool _kAndroidMirrorX = false;

  CameraController? _camController;
  FaceDetector? _faceDetector;
  int _cameraIndex = -1;
  bool _canProcess = true;
  bool _isBusy = false;
  bool _loggedDetectionError = false;
  DateTime _lastProcessed = DateTime.fromMillisecondsSinceEpoch(0);

  @override
  void initState() {
    super.initState();
    if (widget.cameras.any((element) =>
        element.lensDirection == widget.cameraDirection &&
        element.sensorOrientation == 90)) {
      _cameraIndex = widget.cameras.indexOf(
        widget.cameras.firstWhere((cam) =>
            cam.lensDirection == widget.cameraDirection &&
            cam.sensorOrientation == 90),
      );
    } else {
      for (var i = 0; i < widget.cameras.length; i++) {
        if (widget.cameras[i].lensDirection == widget.cameraDirection) {
          _cameraIndex = i;
          break;
        }
      }
    }
    _faceDetector = FaceDetector(options: widget.faceDetectorOptions);
    _startRecording();
  }

  Future _startRecording() async {
    final camera = widget.cameras[_cameraIndex];
    _camController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      // ML Kit's Android bridge only accepts NV21 (or YV12); camera_android's
      // default stream is YUV_420_888, which ML Kit rejects on every frame
      // with "ImageFormat is not supported". iOS keeps its default
      // (bgra8888), which is what ML Kit expects there.
      imageFormatGroup: defaultTargetPlatform == TargetPlatform.android
          ? ImageFormatGroup.nv21
          : null,
    );
    _camController?.initialize().then((_) {
      if (!mounted) return;
      _camController?.startImageStream(_imageProcess);
      setState(() {});
    });
  }

  /// Captures a still photo using the same [CameraController] that powers the
  /// live preview and the face-detection stream — never a second controller,
  /// so the frame the user validated is guaranteed to be the frame captured.
  Future<XFile?> takePicture() async {
    if (_camController == null || !_camController!.value.isInitialized) {
      return null;
    }
    _canProcess = false;
    if (_camController!.value.isStreamingImages) {
      await _camController!.stopImageStream();
    }
    try {
      return await _camController!.takePicture();
    } catch (_) {
      return null;
    }
  }

  Future _imageProcess(CameraImage image) async {
    if (!_canProcess || _isBusy) return;

    final now = DateTime.now();
    if (now.difference(_lastProcessed) < _minProcessInterval) return;
    _lastProcessed = now;

    final controller = _camController;
    if (controller == null || !controller.value.isInitialized) return;

    _isBusy = true;
    try {
      final camera = widget.cameras[_cameraIndex];
      final isAndroid = defaultTargetPlatform == TargetPlatform.android;

      // Android needs the real rotation (sensor + device orientation) so ML
      // Kit can make the raw frame upright; iOS ignores it natively (its
      // buffer is already upright) so the sensor value is just metadata.
      final rotationDegrees = isAndroid
          ? _androidRotationDegrees(controller, camera)
          : camera.sensorOrientation;
      final imageRotation = rotationDegrees == null
          ? null
          : InputImageRotationValue.fromRawValue(rotationDegrees);
      final inputImageFormat =
          InputImageFormatValue.fromRawValue(image.format.raw);
      if (imageRotation == null || inputImageFormat == null) return;

      if (isAndroid && inputImageFormat != InputImageFormat.nv21) {
        _logDetectionErrorOnce(
            'formato de imagem inesperado no Android: $inputImageFormat (esperado nv21)');
        return;
      }

      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }

      final rawWidth = image.width.toDouble();
      final rawHeight = image.height.toDouble();
      final inputImage = InputImage.fromBytes(
        bytes: allBytes.done().buffer.asUint8List(),
        metadata: InputImageMetadata(
          size: Size(rawWidth, rawHeight),
          rotation: imageRotation,
          format: inputImageFormat,
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );

      final faces = await _faceDetector!.processImage(inputImage);
      if (!mounted || !_canProcess) return;

      // Size of the upright frame the boxes are expressed in (see the class
      // doc on FaceFrameResult): on Android, ML Kit reports boxes after
      // applying the rotation, so 90°/270° swap the raw width/height.
      final degrees = _rotationDegrees(imageRotation);
      final swapAxes = isAndroid && (degrees == 90 || degrees == 270);
      final frameSize =
          swapAxes ? Size(rawHeight, rawWidth) : Size(rawWidth, rawHeight);

      // Canonical size the preview is rendered at (see `_viewRender`) — every
      // box gets remapped into this space so detection math and rendering
      // can never disagree about scale, even if the stream's own resolution
      // doesn't exactly match the preview's reported resolution.
      final canonicalSize = Size(1, controller.value.aspectRatio);
      final mirrorX = isAndroid && _kAndroidMirrorX;
      final remappedFaces = [
        for (final face in faces)
          _remapFace(face, frameSize, canonicalSize, mirrorX: mirrorX),
      ];

      widget.resultCallback(FaceFrameResult(
        faces: remappedFaces,
        imageSize: canonicalSize,
        lensDirection: camera.lensDirection,
      ));
    } catch (e, st) {
      // A failure here used to disappear silently (the camera callback has no
      // one to report to), leaving the guide stuck on "no face". Log it once
      // — every frame would fail the same way — and keep the loop alive.
      _logDetectionErrorOnce('$e\n$st');
    } finally {
      // Must always run, even if processImage() throws, otherwise detection
      // silently freezes for the rest of the session.
      _isBusy = false;
    }
  }

  void _logDetectionErrorOnce(String message) {
    if (_loggedDetectionError) return;
    _loggedDetectionError = true;
    debugPrint('[face_detection] falha ao processar frame: $message');
  }

  int _rotationDegrees(InputImageRotation rotation) {
    switch (rotation) {
      case InputImageRotation.rotation0deg:
        return 0;
      case InputImageRotation.rotation90deg:
        return 90;
      case InputImageRotation.rotation180deg:
        return 180;
      case InputImageRotation.rotation270deg:
        return 270;
    }
  }

  /// Rotation ML Kit needs on Android to make the raw sensor frame upright,
  /// computed the way the `google_mlkit_commons` README prescribes: the
  /// sensor orientation compensated by the current device orientation, with
  /// the sign flipped for front-facing cameras.
  int? _androidRotationDegrees(
      CameraController controller, CameraDescription camera) {
    const orientations = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 90,
      DeviceOrientation.portraitDown: 180,
      DeviceOrientation.landscapeRight: 270,
    };
    final compensation = orientations[controller.value.deviceOrientation];
    if (compensation == null) return null;
    return camera.lensDirection == CameraLensDirection.front
        ? (camera.sensorOrientation + compensation) % 360
        : (camera.sensorOrientation - compensation + 360) % 360;
  }

  Face _remapFace(Face face, Size frameSize, Size canonicalSize,
      {required bool mirrorX}) {
    final box = face.boundingBox;
    final fractionalLeft = box.left / frameSize.width;
    final fractionalWidth = box.width / frameSize.width;
    final fractional = Rect.fromLTWH(
      mirrorX ? 1 - fractionalLeft - fractionalWidth : fractionalLeft,
      box.top / frameSize.height,
      fractionalWidth,
      box.height / frameSize.height,
    );
    final canonicalBox = Rect.fromLTWH(
      fractional.left * canonicalSize.width,
      fractional.top * canonicalSize.height,
      fractional.width * canonicalSize.width,
      fractional.height * canonicalSize.height,
    );
    return Face(
      boundingBox: canonicalBox,
      // Landmarks/contours aren't remapped: they're disabled in
      // FaceDetectorOptions for this flow, so these maps are always empty.
      // If a future change enables them, remap their points too.
      landmarks: face.landmarks,
      contours: face.contours,
      headEulerAngleX: face.headEulerAngleX,
      headEulerAngleY: face.headEulerAngleY,
      headEulerAngleZ: face.headEulerAngleZ,
      leftEyeOpenProbability: face.leftEyeOpenProbability,
      rightEyeOpenProbability: face.rightEyeOpenProbability,
      smilingProbability: face.smilingProbability,
      trackingId: face.trackingId,
    );
  }

  Widget _viewRender() {
    final controller = _camController;
    if (controller == null || !controller.value.isInitialized) {
      return const ColoredBox(color: Colors.black);
    }

    // `controller.value.aspectRatio` is the plugin's own, always-correct,
    // cross-platform ratio for the *rendered* preview — it's what
    // `CameraPreview` uses internally to size (and, on Android, counter-
    // rotate) itself. Building our cover-fit box from it, instead of from
    // our own per-frame rotation guess, keeps the preview correct even if
    // that guess is ever wrong for a given device/platform.
    final camAspect = controller.value.aspectRatio;

    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: 1,
              height: camAspect,
              child: CameraPreview(controller),
            ),
          ),
          widget.overlay ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _viewRender());
  }

  Future _stopRecording() async {
    _canProcess = false;
    if (_camController?.value.isStreamingImages == true) {
      await _camController?.stopImageStream();
    }
    await _camController?.dispose();
    _camController = null;
  }

  @override
  void dispose() {
    _stopRecording();
    _faceDetector!.close();
    super.dispose();
  }
}
