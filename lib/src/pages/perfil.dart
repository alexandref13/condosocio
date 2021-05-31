import 'dart:io';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/perfil_controller.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  LoginController loginController = Get.put(LoginController());
  PerfilController perfilController = Get.put(PerfilController());

  final uri = Uri.parse("https://condosocio.com.br/flutter/upload_imagem.php");
  File _selectedFile;
  final _picker = ImagePicker();

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
          //Navigator.pushNamed(context, '/Home');
        },
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 40),
                  child: Center(
                    child: Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).accentColor)),
            ],
          ),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              image: new FileImage(_selectedFile),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          _configurandoModalBottomSheet(context);
          //Navigator.pushNamed(context, '/Home');
        },
        child: loginController.imgperfil.value == ''
            ? Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Center(
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).accentColor,
                        )),
                  ],
                ),
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://condosocio.com.br/acond/downloads/fotosperfil/${loginController.imgperfil.value}'),
                  ),
                ),
              ),
      );
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile image = await _picker.getImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
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
          Get.back();
        }
      });
    }
  }

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile.path);
    request.files.add(pic);
    var response = await request.send();
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'Imagem do perfil alterada',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.green,
          icon: Icons.check);
    } else {
      Navigator.of(context).pop();
      EdgeAlert.show(context,
          title: 'Imagem não enviada',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
    }
    _selectedFile = null;
  }

  void _configurandoModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.only(bottom: 30),
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Center(
                        child: Text(
                  "Alterar Imagem",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ))),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    title: new Text('Câmera'),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    onTap: () => {getImage(ImageSource.camera)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                    leading: new Icon(Icons.collections,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    title: new Text('Galeria de Fotos'),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    onTap: () => {getImage(ImageSource.gallery)}),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }

  //Mudar para os campos que terão no condosocio, por enquanto usando backend da focus
  DateTime data = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Perfil',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Obx(() {
            return perfilController.isLoading.value
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
                                onTap: () {
                                  _configurandoModalBottomSheet(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    'Alterar foto de perfil',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          customTextField(
                            context,
                            'Nome',
                            null,
                            false,
                            1,
                            true,
                            perfilController.name.value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          customTextField(
                            context,
                            'Sobrenome',
                            null,
                            false,
                            1,
                            true,
                            perfilController.secondName.value,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              perfilController.birthDateMaskFormatter
                            ],
                            controller: perfilController.birthdate.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  width: 1,
                                ),
                              ),
                              labelText: 'Data de aniversário',
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              perfilController.cellMaskFormatter
                            ],
                            controller: perfilController.phone.value,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  width: 1,
                                ),
                              ),
                              labelText: 'Celular',
                              labelStyle: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context).accentColor;
                                  },
                                ),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (Set<MaterialState> states) {
                                  return 3;
                                }),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    );
                                  },
                                ),
                              ),
                              onPressed: () {
                                perfilController.editPerfil().then((value) {
                                  if (value == 1) {
                                    edgeAlertWidget(
                                      context,
                                      'Perfil atualizado',
                                    );
                                  } else {
                                    onAlertButtonPressed(
                                        context,
                                        'Algo deu errado\n Tente novamente',
                                        '/home');
                                  }
                                });
                              },
                              child: Text(
                                "ENVIAR",
                                style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          })),
    );
  }
}
