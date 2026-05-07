import 'dart:async';
import 'dart:io';
import 'package:condosocio/main.dart';
import 'package:condosocio/src/controllers/facial_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/pages/acessos/face_detection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import '../../components/utils/edge_alert_widget.dart';
import '../../components/utils/edge_alert_error_widget.dart';

enum _FaceState { none, tooSmall, centered }

class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  final _overlayKey = GlobalKey<FaceDetectionOverlayState>();

  _FaceState _faceState = _FaceState.none;
  int _countdown = 3;
  Timer? _countdownTimer;
  bool _capturing = false;

  LoginController loginController = Get.put(LoginController());
  FacialController facialController = Get.put(FacialController());
  File? _selectedFile;

  final uri = Uri.parse(
      "https://www.condosocio.com.br/flutter/upload_imagem_facial.php");

  Color get _stateColor {
    switch (_faceState) {
      case _FaceState.none:
        return Colors.red.shade700;
      case _FaceState.tooSmall:
        return Colors.orange;
      case _FaceState.centered:
        return Colors.green.shade700;
    }
  }

  String get _stateMessage {
    switch (_faceState) {
      case _FaceState.none:
        return 'Centralize o rosto dentro da área oval';
      case _FaceState.tooSmall:
        return 'Aproxime um pouco o rosto da câmera';
      case _FaceState.centered:
        return 'Rosto centralizado. Fique parado.\nCapturando em $_countdown...';
    }
  }

  Widget _overlay() {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Dark overlay with oval cutout
        CustomPaint(
          painter: _OvalOverlayPainter(
            ovalWidth: size.width * 0.75,
            ovalHeight: size.height * 0.48,
          ),
          child: const SizedBox.expand(),
        ),
        // Colored oval border
        Center(
          child: SizedBox(
            width: size.width * 0.75,
            height: size.height * 0.48,
            child: CustomPaint(
              painter: _OvalBorderPainter(color: _stateColor),
            ),
          ),
        ),
        // Status banner
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Container(
              width: size.width * 0.88,
              margin: const EdgeInsets.only(top: 16),
              padding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: _stateColor,
              ),
              child: Text(
                _stateMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FaceDetectionOverlay(
          key: _overlayKey,
          cameras: cameras,
          faceDetectorOptions: FaceDetectorOptions(
            enableClassification: false,
            enableContours: false,
          ),
          overlay: _overlay(),
          resultCallback: _resultCallback,
        ),
        Positioned(
          bottom: 30.0,
          left: 16.0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 34),
            onPressed: () => Get.back(),
          ),
        ),
      ],
    );
  }

  void _resultCallback(List result) {
    if (_capturing) return;

    if (result.isEmpty) {
      _cancelCountdown();
      if (_faceState != _FaceState.none) {
        setState(() => _faceState = _FaceState.none);
      }
      return;
    }

    final face = result.first as Face;
    final size = MediaQuery.of(context).size;

    final ovalWidth = size.width * 0.75;
    final ovalHeight = size.height * 0.48;
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final ovalLeft = centerX - ovalWidth / 2;
    final ovalTop = centerY - ovalHeight / 2;
    final ovalRight = centerX + ovalWidth / 2;
    final ovalBottom = centerY + ovalHeight / 2;

    final minFaceWidth = ovalWidth * 0.38;

    final box = face.boundingBox;
    final faceCX = box.left + box.width / 2;
    final faceCY = box.top + box.height / 2;

    final inBounds = faceCX > ovalLeft &&
        faceCX < ovalRight &&
        faceCY > ovalTop &&
        faceCY < ovalBottom;

    final bigEnough = box.width >= minFaceWidth;

    if (inBounds && bigEnough) {
      if (_faceState != _FaceState.centered) {
        _cancelCountdown();
        setState(() {
          _faceState = _FaceState.centered;
          _countdown = 3;
        });
        _startCountdown();
      }
    } else if (box.width > 0 && !bigEnough) {
      _cancelCountdown();
      if (_faceState != _FaceState.tooSmall) {
        setState(() => _faceState = _FaceState.tooSmall);
      }
    } else {
      _cancelCountdown();
      if (_faceState != _FaceState.none) {
        setState(() => _faceState = _FaceState.none);
      }
    }
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _countdown--);
      if (_countdown <= 0) {
        timer.cancel();
        _capture();
      }
    });
  }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    _countdown = 3;
  }

  Future<void> _capture() async {
    if (_capturing) return;
    setState(() => _capturing = true);

    final image = await _overlayKey.currentState?.takePicture();
    if (image == null) {
      setState(() => _capturing = false);
      return;
    }

    await _processImage(image.path);
  }

  Future<void> _processImage(String imagePath) async {
    final img.Image originalImage =
        img.decodeImage(File(imagePath).readAsBytesSync())!;

    final double desiredSizePercentage = 0.57;
    final int squareSize =
        (originalImage.width * desiredSizePercentage).toInt();
    final int offsetX = ((originalImage.width - squareSize) ~/ 2)
        .clamp(0, originalImage.width - squareSize);
    final int offsetY = ((originalImage.height - squareSize) ~/ 2)
        .clamp(0, originalImage.height - squareSize);

    final img.Image croppedImage = img.copyCrop(
      originalImage,
      x: offsetX,
      y: offsetY,
      width: squareSize,
      height: squareSize,
    );

    final File croppedFile =
        File(imagePath.replaceAll('.jpg', '_cropped.jpg'));
    croppedFile.writeAsBytesSync(img.encodeJpg(croppedImage));
    _selectedFile = croppedFile;

    await uploadImage();
    Get.toNamed('/facial');
  }

  Future uploadImage() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator()),
    );

    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic =
        await http.MultipartFile.fromPath("image", _selectedFile!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      loginController.newLogin(loginController.id.value);
      Navigator.of(context).pop();
      showToast(context, 'Parabéns!', 'Imagem Facial Enviada com Sucesso!');
    } else if (response.statusCode == 404) {
      loginController.imgfacial.value = '';
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
      showToastError(context, 'Houve Algum Problema! Tente novamente');
    }
    _selectedFile = null;
  }

  @override
  void dispose() {
    _cancelCountdown();
    super.dispose();
  }
}

class _OvalOverlayPainter extends CustomPainter {
  final double ovalWidth;
  final double ovalHeight;

  _OvalOverlayPainter({required this.ovalWidth, required this.ovalHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withValues(alpha: 0.55);

    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: ovalWidth,
      height: ovalHeight,
    );

    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final ovalPath = Path()..addOval(ovalRect);
    final combined =
        Path.combine(PathOperation.difference, fullPath, ovalPath);

    canvas.drawPath(combined, paint);
  }

  @override
  bool shouldRepaint(_OvalOverlayPainter old) =>
      ovalWidth != old.ovalWidth || ovalHeight != old.ovalHeight;
}

class _OvalBorderPainter extends CustomPainter {
  final Color color;

  _OvalBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5;

    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(_OvalBorderPainter old) => color != old.color;
}
