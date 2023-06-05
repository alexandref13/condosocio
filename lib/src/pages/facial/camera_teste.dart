import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CameraController? _controller;
  XFile? _capturedImage;
  bool _showOverlay = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(
      camera,
      ResolutionPreset.high,
    );

    try {
      await _controller!.initialize();
    } catch (e) {
      _showCameraError(e.toString());
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _showCameraError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Camera Error: $message'),
      ),
    );
  }

  void _captureImage() async {
    if (!_controller!.value.isInitialized) {
      _showCameraError('Camera is not initialized.');
      return;
    }

    try {
      XFile capturedImage = await _controller!.takePicture();
      setState(() {
        _capturedImage = capturedImage;
        _showOverlay = true;
      });
    } catch (e) {
      _showCameraError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller!.value.isInitialized) {
      return Container();
    }

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: CameraPreview(_controller!),
          ),
          if (_showOverlay)
            Positioned.fill(
              child: Image.asset(
                'images/error.png',
                fit: BoxFit.cover,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                onPressed: _captureImage,
                child: Icon(Icons.camera),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
