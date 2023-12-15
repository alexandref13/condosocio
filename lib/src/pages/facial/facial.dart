import 'dart:io';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../components/utils/alert_button_pressed.dart';
import '../../components/utils/confirmed_button_pressed.dart';
import '../../components/utils/edge_alert_error_widget.dart';
import '../../components/utils/edge_alert_widget.dart';
import '../../controllers/facial_controller.dart';
import '../../controllers/ouvidoria/ouvidoria_controller.dart';

class Facial extends StatefulWidget {
  @override
  _FacialState createState() => _FacialState();
}

class _FacialState extends State<Facial> {
  LoginController loginController = Get.put(LoginController());
  FacialController facialController = Get.put(FacialController());
  OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());

  final _picker = ImagePicker();
  File? _selectedFile;

  final uri =
      Uri.parse("https://alvocomtec.com.br/flutter/upload_imagem_facial.php");

  void refreshPage() {
    setState(() {
      facialController.isLoading.value = false;
    });
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return GestureDetector(
          onTap: () => {
                loginController.ctlfacial.value == "0" &&
                        loginController.imgfacial.value == ""
                    ? getImage(ImageSource.camera)
                    : Get.toNamed('/fotoFacial'),
              },
          child: Hero(
            tag: 'fotoFacial',
            child: Container(
              margin: EdgeInsets.only(left: 100, bottom: 5),
              child: Center(
                child: loginController.ctlfacial.value != "1"
                    ? Icon(
                        Icons.edit,
                        size: 20,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                      )
                    : Icon(
                        Icons.search,
                        size: 20,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                      ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ));
    } else {
      return GestureDetector(
          onTap: () => {
                loginController.ctlfacial.value == "0" &&
                        loginController.imgfacial.value == ""
                    ? getImage(ImageSource.camera)
                    : Get.toNamed('/fotoFacial'),
              },
          child: loginController.imgfacial.value == ''
              ? Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Center(
                          child: loginController.ctlfacial.value != "1"
                              ? Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                )
                              : Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/user.png'),
                    ),
                  ),
                )
              : Hero(
                  tag: 'fotoFacial',
                  transitionOnUserGestures: true,
                  child: Material(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 10,
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 105, bottom: 0),
                            child: Center(
                              child: loginController.ctlfacial.value != "1" &&
                                      loginController.imgfacial.value == ''
                                  ? Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    )
                                  : Icon(
                                      Icons.search,
                                      size: 20,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://alvocomtec.com.br/acond/downloads/fotosperfil/${loginController.imgfacial.value}'),
                        ),
                      ),
                    ),
                  ),
                ));
    }
  }

  /*getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile? image = await _picker.getImage(source: source);
    if (image != null) {
      File? cropped = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 80,
          maxWidth: 400,
          maxHeight: 400,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "Imagem para o Perfil",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = File(image.path);
        _selectedFile = cropped;
        if (cropped != null) {
          uploadImage();
          //Get.back();
          Get.toNamed('/facial');
        }
      });
    }
  }*/

  Future<void> getImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image != null) {
      final CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        maxWidth: 400,
        maxHeight: 400,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Imagem Para Acesso de Saída',
            toolbarColor: Colors.deepOrange,
            initAspectRatio: CropAspectRatioPreset.original,
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cortar Imagem',
          ),
        ],
      );

      this.setState(() {
        _selectedFile = File(image.path);
        if (cropped != null) {
          _selectedFile = File(cropped.path);
          uploadImage();
          //Get.back();
          Get.toNamed('/facial');
        }
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
    print("Meu arquivo => ${_selectedFile!.path}");
    request.files.add(pic);
    var response = await request.send();
    print(response.request);
    if (response.statusCode == 200) {
      loginController.newLogin(loginController.id.value);
      Navigator.of(context).pop(); // Fechar o indicador de progresso
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

  //Mudar para os campos que terão no condosocio, por enquanto usando backend da focus
  DateTime data = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Biometria Facial',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return facialController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * .95,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              getImageWidget(),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => {getImage(ImageSource.camera)},
                                child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child:
                                        loginController.ctlfacial.value != "1"
                                            ? Text(
                                                'Clique para fazer o selfie',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                ),
                                              )
                                            : Text(
                                                'Clique para ampliar imagem',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                ),
                                              )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          loginController.ctlfacial.value == "0" &&
                                  loginController.imgfacial.value == ""
                              ? Container(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Para inserir a sua biometria facial, siga os passos abaixo:',
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '1) Clique na imagem acima:',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '2) Ao clicar na imagem, a câmera do seu dispositivo será ativada automaticamente.',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '3) Posicione-se em frente, olhe diretamente para a câmera e faça um selfie, garantindo que seu rosto esteja bem visível.',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '4) Não utilize máscaras faciais ou óculos durante a captura da imagem.',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '5) Garanta que a imagem capturada esteja nítida e bem iluminada, para garantir uma identificação precisa.',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '6) Após capturar o selfie, você poderá revisar a imagem e confirmar se está satisfeito com ela.',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            SizedBox(height: 18.0),
                                            Text(
                                              '7) Caso esteja satisfeito, prossiga com o envio da foto. Caso contrário, repita o processo para obter uma nova imagem.',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      /*SizedBox(height: 16.0),
                                      Container(
                                        padding: EdgeInsets.all(16.0),
                                        color: Colors.amber,
                                        child: Text(
                                          'A biometria facial é uma medida de segurança que nos permite validar a sua identidade de forma confiável e proteger suas informações. Garantimos que suas imagens serão tratadas com sigilo e privacidade, sendo utilizadas exclusivamente para a finalidade de autenticação.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black87),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        // color: Colors.amber,
                                        child: Text(
                                          'Para garantir a segurança, é necessário solicitar a autorização da administração do condomínio para realizar a alteração da imagem da sua biometria facial.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                            padding: EdgeInsets.all(20),
                                            child: ButtonTheme(
                                              height: 50.0,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      return Theme.of(context)
                                                          .colorScheme
                                                          .secondary;
                                                    },
                                                  ),
                                                  elevation:
                                                      MaterialStateProperty
                                                          .resolveWith<
                                                              double>((Set<
                                                                  MaterialState>
                                                              states) {
                                                    return 3;
                                                  }),
                                                  shape: MaterialStateProperty
                                                      .resolveWith<
                                                          OutlinedBorder>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      return RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                onPressed: () {
                                                  ouvidoriaController
                                                          .message.value.text =
                                                      'Solicito o reset de minha imagem facial (mensagem pelo app)';
                                                  ouvidoriaController
                                                          .itemSelecionado
                                                          .value =
                                                      'Alteração facial';
                                                  ouvidoriaController
                                                      .sendOuvidoria()
                                                      .then(
                                                    (response) {
                                                      if (response == 1) {
                                                        confirmedButtonPressed(
                                                          context,
                                                          'Enviado com sucesso!',
                                                          'ouvidoria',
                                                        );
                                                      } else if (response ==
                                                          'vazio') {
                                                        onAlertButtonPressed(
                                                            context,
                                                            'Assunto e Mensagem são campos obrigátorios',
                                                            '',
                                                            'images/error.png');
                                                      } else {
                                                        onAlertButtonPressed(
                                                            context,
                                                            'Algo deu errado\n Tente novamente',
                                                            '/home',
                                                            'images/error.png');
                                                      }
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  "Solicitar Alteração da Imagem",
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor!,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ])),
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
