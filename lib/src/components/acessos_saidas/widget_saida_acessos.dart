import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/saida/visualizar_acessos_saida_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;

class SaidaAcessos extends StatefulWidget {
  @override
  _SaidaAcessosState createState() => _SaidaAcessosState();
}

class _SaidaAcessosState extends State<SaidaAcessos> {
  LoginController loginController = Get.put(LoginController());
  VisualizarAcessosSaidaController saidaController =
      Get.put(VisualizarAcessosSaidaController());

  final picker = ImagePicker();
  File selectedFile;

  final uri = Uri.parse("https://condosocio.com.br/flutter/upload_imagem.php");

  Future uploadImage() async {
    var request = http.MultipartRequest('POST', uri);
    request.fields['idusu'] = loginController.id.value;
    var pic = await http.MultipartFile.fromPath("image", selectedFile.path);
    print("meu arquivo => ${selectedFile.path}");
    request.files.add(pic);
    var response = await request.send();
    print(response.request);

    if (response.statusCode == 200) {
      Get.back();
      edgeAlertWidget(context, 'Imagem Enviada');
    } else if (response.statusCode == 404) {
      loginController.imgperfil.value = '';
    } else {
      Get.back();
      EdgeAlert.show(
        context,
        title: 'Imagem Não Enviada',
        gravity: EdgeAlert.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icons.highlight_off,
      );
    }
    selectedFile = null;
  }

  getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile image = await picker.getImage(source: source);
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
        selectedFile = File(image.path);
        selectedFile = cropped;
        if (cropped != null) {
          uploadImage();
        }
      });
    }
  }

  TextEditingController name = new TextEditingController();
  TextEditingController observation = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            customTextField(
                context, 'Nome Completo', null, false, 1, true, name),
            SizedBox(
              height: 10,
            ),
            customTextField(
                context, 'Observações', null, true, 5, true, observation),
            SizedBox(
              height: 10,
            ),
            selectedFile != null
                ? Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 130),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedFile = null;
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              size: 20,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: new FileImage(selectedFile),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context)
                              .textSelectionTheme
                              .selectionColor;
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                        return 3;
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    onPressed: () {
                      acessosSaidaModalBottomSheet();
                    },
                    child: Text(
                      "ANEXAR IMAGEM",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context).buttonColor, fontSize: 16),
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context).accentColor;
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                        return 3;
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "AUTORIZAR",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 16),
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context)
                              .textSelectionTheme
                              .selectionColor;
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                        return 3;
                      }),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/visualizarAcessosSaidas');
                    },
                    child: Text(
                      "VISUALIZE SAÍDAS",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context).buttonColor, fontSize: 16),
                    ),
                  ),
                )),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  acessosSaidaModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).accentColor,
            margin: EdgeInsets.only(bottom: 30),
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
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  title: new Text('Câmera'),
                  trailing: new Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  onTap: () => {
                    getImage(ImageSource.camera),
                  },
                ),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                ListTile(
                  leading: new Icon(Icons.collections,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                  title: new Text('Galeria de Fotos'),
                  trailing: new Icon(Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                  onTap: () => {
                    getImage(
                      ImageSource.gallery,
                    ),
                  },
                ),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context).primaryColor;
                          },
                        ),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            );
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
