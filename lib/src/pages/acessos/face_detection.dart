import 'package:condosocio/main.dart';
import 'package:condosocio/src/components/utils/edge_alert_error_widget.dart';
import 'package:condosocio/src/controllers/facial_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/pages/acessos/face_detection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../components/utils/edge_alert_widget.dart';
import 'package:image/image.dart' as img;

class FaceDetectionPage extends StatefulWidget {
  const FaceDetectionPage({super.key});

  @override
  State<FaceDetectionPage> createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  bool _faceFound = false;
  bool _showCaptureButton = false;
  LoginController loginController = Get.put(LoginController());
  FacialController facialController = Get.put(FacialController());
  //List<CameraDescription> cameras = [];
  final _picker = ImagePicker();
  File? _selectedFile;

  final uri = Uri.parse(
      "https://www.condosocio.com.br/flutter/upload_imagem_facial.php");

  void refreshPage() {
    setState(() {
      facialController.isLoading.value = false;
    });
  }

  Widget _overlay() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.10,
            height: MediaQuery.of(context).size.height * 0.4001,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.10,
            height: MediaQuery.of(context).size.height * 0.4001,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.82,
            height: MediaQuery.of(context).size.height * 0.41,
            decoration: BoxDecoration(
              border: Border.all(
                color: _faceFound ? Colors.green.shade700 : Colors.red.shade700,
                width: 5.0,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.80,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _faceFound ? Colors.green.shade700 : Colors.red.shade700,
              ),
              child: Text(
                _faceFound
                    ? 'Detecção de rosto bem-sucedida\nClique no botão para capturar a imagem.'
                    : 'Falha na detecção de rosto',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FaceDetectionOverlay(
          cameras: cameras,
          faceDetectorOptions: FaceDetectorOptions(
            enableClassification: false,
            enableContours: false,
          ),
          overlay: _overlay(),
          resultCallback: _resultCallback,
        ),
        Positioned(
          bottom: 30.0, // Ajuste conforme necessário
          left: 16.0, // Ajuste conforme necessário
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 34,
            ),
            onPressed: () {
              Get.back(); //Navigator.of(context).pop() são comuns
            },
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height *
              0.2, // Ajuste conforme necessário
          left: MediaQuery.of(context).size.width *
              0.42, // Ajuste conforme necessário
          child: Visibility(
            visible: _showCaptureButton,
            child: FloatingActionButton(
              onPressed: () {
                _takePicture();
              },
              child: Icon(Icons.camera),
              heroTag: 'uniqueTag', // Ajuste esse valor para mudar o tamanho
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _takePicture() async {
    final CameraController controller = CameraController(
      cameras[1], // Seleciona a primeira câmera, ajuste conforme necessário
      ResolutionPreset.medium, // Especifique a resolução desejada
    );

    await controller.initialize();
    // Ativar o flash
    await controller.setFlashMode(FlashMode
        .always); // ou FlashMode.auto, FlashMode.off conforme necessário

    final XFile image = await controller.takePicture();

    await _processImage(image.path);

    controller.dispose();
  }

  Future<void> _processImage(String imagePath) async {
    // Carregue a imagem original
    final img.Image originalImage =
        img.decodeImage(File(imagePath).readAsBytesSync())!;

    // Calcule o tamanho desejado do corte
    final double desiredSizePercentage = 0.57;

    // Determine o lado do quadrado
    final int squareSize =
        (originalImage.width * desiredSizePercentage).toInt();

    // Calcule as coordenadas do corte mantendo-o no centro
    final int offsetX = ((originalImage.width - squareSize) ~/ 2)
        .clamp(0, originalImage.width - squareSize);
    final int offsetY = ((originalImage.height - squareSize) ~/ 2)
        .clamp(0, originalImage.height - squareSize);

    // Realize o corte
    final img.Image croppedImage = img.copyCrop(
      originalImage,
      x: offsetX,
      y: offsetY,
      width: squareSize,
      height: squareSize,
    );

    // Salve a imagem cortada em um novo arquivo
    final File croppedFile = File(imagePath.replaceAll('.jpg', '_cropped.jpg'));
    croppedFile.writeAsBytesSync(img.encodeJpg(croppedImage));

    // Atualize a variável _selectedFile com a imagem cortada
    _selectedFile = croppedFile;

    // Faça o upload da imagem cortada
    await uploadImage();

    // Navegue para a próxima tela
    Get.toNamed('/facial');
  }

  void _resultCallback(List result) {
    if (result.isNotEmpty) {
      for (final Face face in result) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;

        final xPositionStart = width * 0.15;
        final xPositionEnd = width - (width * 0.15);
        final yPositionStart = height * 0.30;
        final yPositionEnd = height - (height * 0.30);

        if ((face.boundingBox.left > xPositionStart &&
                face.boundingBox.left < xPositionEnd) &&
            (face.boundingBox.top > yPositionStart &&
                face.boundingBox.top < yPositionEnd)) {
          setState(() {
            _faceFound = true;
            _showCaptureButton = true;
          });
        } else {
          setState(() {
            _faceFound = false;
            _showCaptureButton = false;
          });
        }
      }
    } else {
      setState(() {
        _faceFound = false;
      });
    }
  }

  Future uploadImage() async {
    // Mostrar indicador de progresso
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile!.path);
    print("Meu arquivo detextion => ${_selectedFile!.path}");
    request.files.add(pic);
    var response = await request.send();
    print(response.request);
    if (response.statusCode == 200) {
      loginController.newLogin(loginController.id.value);
      Navigator.of(context).pop(); // Fechar o indicador de progresso
      //Get.offNamed('/facial');
      showToast(context, 'Parabéns!', 'Imagem Facial Enviada com Sucesso!');
    } else if (response.statusCode == 404) {
      loginController.imgfacial.value = '';
      Navigator.of(context).pop(); // Fechar o indicador de progresso
    } else {
      Navigator.of(context).pop(); // Fechar o indicador de progresso
      showToastError(context, 'Houve Algum Problema! Tente novamente');
    }
    _selectedFile = null;
  }
}
