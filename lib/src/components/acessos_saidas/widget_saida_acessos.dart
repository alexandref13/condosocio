import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/saida/visualizar_acessos_saida_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SaidaAcessos extends StatefulWidget {
  @override
  _SaidaAcessosState createState() => _SaidaAcessosState();
}

class _SaidaAcessosState extends State<SaidaAcessos> {
  LoginController loginController = Get.put(LoginController());

  VisualizarAcessosSaidaController saidaController =
      Get.put(VisualizarAcessosSaidaController());

  final picker = ImagePicker();
  File? selectedFile;

  getImage(ImageSource source) async {
    this.setState(() {});
    PickedFile? image = await picker.getImage(source: source);
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
            toolbarTitle: "Imagem Para Acesso de Saída",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        selectedFile = File(image.path);
        selectedFile = cropped;
        if (cropped != null) {
          Get.back();
        }
      });
    }
  }

  void dropDownItemSelected(String novoItem) {
    saidaController.itemSelecionado.value = novoItem;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return saidaController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor!,
                            width: 1,
                          ),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            size: 27,
                          ),
                          iconEnabledColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                          dropdownColor: Theme.of(context).primaryColor,
                          style: GoogleFonts.montserrat(fontSize: 14),
                          items: saidaController.tipos
                              .map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            dropDownItemSelected(novoItemSelecionado!);
                            saidaController.itemSelecionado.value =
                                novoItemSelecionado;
                          },
                          value: saidaController.itemSelecionado.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(
                            context,
                            'Nome Completo',
                            '',
                            false,
                            1,
                            150,
                            true,
                            saidaController.nameController.value),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(context, 'Observações', '', true,
                            5, 1500, true, saidaController.obs.value),
                      ),
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
                                            .selectionColor!,
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
                                  image: new FileImage(selectedFile!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!;
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
                                acessosSaidaModalBottomSheet();
                              },
                              child: Text(
                                "ANEXAR IMAGEM",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .secondary;
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
                                saidaController
                                    .sendAcessosSaida(selectedFile == null
                                        ? ''
                                        : selectedFile!.path)
                                    .then(
                                  (value) {
                                    if (value == '1') {
                                      saidaController.itemSelecionado.value =
                                          'Selecione o tipo de visitante';
                                      saidaController
                                          .nameController.value.text = '';
                                      saidaController.obs.value.text = '';
                                      selectedFile = null;
                                      alertButton();
                                    } else if (value == 'vazio') {
                                      onAlertButtonPressed(
                                        context,
                                        'Os campos de tipo de visitante, nome e observação são obrigátorios',
                                        '',
                                        'sim',
                                      );
                                    } else {
                                      saidaController.itemSelecionado.value =
                                          'Selecione o tipo de visitante';
                                      saidaController
                                          .nameController.value.text = '';
                                      saidaController.obs.value.text = '';
                                      selectedFile = null;
                                      onAlertButtonPressed(
                                          context,
                                          'Houve algum problema!\n Tente novamente',
                                          '/home',
                                          'images/error.png');
                                    }
                                  },
                                );
                              },
                              child: Text(
                                "AUTORIZAR",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!;
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
                                Get.toNamed('/visualizarAcessosSaidas');
                              },
                              child: Text(
                                "VISUALIZE SAÍDAS",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }

  alertButton() {
    return Alert(
      image: Icon(
        Icons.check,
        color: Colors.green,
        size: 60,
      ),
      style: AlertStyle(
        backgroundColor: Theme.of(context).textSelectionTheme.selectionColor!,
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 300),
        titleStyle: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.error,
          fontSize: 18,
        ),
      ),
      context: context,
      title: 'Sua autorização foi enviada com sucesso à Portaria!',
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () {
            saidaController.getAcessosSaida();
            Get.toNamed('/visualizarAcessosSaidas');
          },
          width: 80,
          color: Colors.green,
        )
      ],
    ).show();
  }

  acessosSaidaModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).colorScheme.secondary,
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
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                  leading: new Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                  title: new Text('Câmera'),
                  trailing: new Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                  onTap: () => {
                    getImage(ImageSource.camera),
                  },
                ),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                ListTile(
                  leading: new Icon(Icons.collections,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                  title: new Text('Galeria de Fotos'),
                  trailing: new Icon(Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                  onTap: () => {
                    getImage(
                      ImageSource.gallery,
                    ),
                  },
                ),
                Divider(
                  height: 20,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          );
        });
  }
}
