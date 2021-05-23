import 'dart:io';

import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdicionarOcorrencias extends StatefulWidget {
  const AdicionarOcorrencias({Key key}) : super(key: key);

  @override
  _AdicionarOcorrenciasState createState() => _AdicionarOcorrenciasState();
}

class _AdicionarOcorrenciasState extends State<AdicionarOcorrencias> {
  OcorrenciasController ocorrenciasController =
      Get.put(OcorrenciasController());

  final picker = ImagePicker();
  File selectedFile;

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

  @override
  Widget build(BuildContext context) {
    void _dropDownItemSelected(String novoItem) {
      ocorrenciasController.itemSelecionado.value = novoItem;
    }

    ocorrenciasSaidaModalBottomSheet() {
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
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    title: new Text('Galeria de Fotos'),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
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
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            );
          });
    }

    return SingleChildScrollView(
      child: Obx(() {
        return ocorrenciasController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Container(
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
                                .selectionColor,
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
                              .selectionColor,
                          dropdownColor: Theme.of(context).primaryColor,
                          style: GoogleFonts.montserrat(fontSize: 14),
                          items: ocorrenciasController.tipos
                              .map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String novoItemSelecionado) {
                            _dropDownItemSelected(novoItemSelecionado);
                            ocorrenciasController.itemSelecionado.value =
                                novoItemSelecionado;
                          },
                          value: ocorrenciasController.itemSelecionado.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(
                          context,
                          'Titulo',
                          null,
                          false,
                          1,
                          true,
                          ocorrenciasController.title.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(
                          context,
                          'Data',
                          null,
                          false,
                          1,
                          false,
                          ocorrenciasController.date.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(
                          context,
                          'Hora',
                          null,
                          false,
                          1,
                          false,
                          ocorrenciasController.hour.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(
                          context,
                          'Descrição',
                          null,
                          true,
                          5,
                          true,
                          ocorrenciasController.description.value,
                        ),
                      ),
                      selectedFile != null
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 130,
                                    ),
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
                                        .selectionColor;
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
                                ocorrenciasSaidaModalBottomSheet();
                              },
                              child: Text(
                                "ANEXAR IMAGEM",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor,
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
                                ocorrenciasController
                                    .sendOcorrencia(
                                  selectedFile == null ? '' : selectedFile.path,
                                )
                                    .then((value) {
                                  if (value == 'vazio') {
                                    onAlertButtonPressed(
                                      context,
                                      'Os campos tipo, titulo e descrição são obrigatorios',
                                      null,
                                    );
                                  } else if (value == '1') {
                                    confirmedOcorrenciaAlert(
                                      context,
                                      'Sua ocorrencia foi autorizada com sucesso!',
                                    );
                                  } else {
                                    onAlertButtonPressed(
                                      context,
                                      'Houve algum problema!\n Tente novamente',
                                      '/home',
                                    );
                                  }
                                });
                              },
                              child: Text(
                                "AUTORIZAR",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
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
              );
      }),
    );
  }

  confirmedOcorrenciaAlert(context, String text) {
    Alert(
      image: Icon(
        Icons.check,
        color: Colors.green,
        size: 60,
      ),
      style: AlertStyle(
        backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 300),
        titleStyle: GoogleFonts.poppins(
          color: Theme.of(context).errorColor,
          fontSize: 18,
        ),
      ),
      context: context,
      title: text,
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
            Get.back();
          },
          width: 80,
          color: Colors.green,
        )
      ],
    ).show();
  }
}

// Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 height: 40,
//                 padding: EdgeInsets.all(7),
//                 margin: EdgeInsets.all(7),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: Theme.of(context).textSelectionTheme.selectionColor,
//                     width: 1,
//                   ),
//                 ),
//                 child: DropdownButton<String>(
//                   isExpanded: true,
//                   underline: Container(),
//                   icon: Icon(
//                     Icons.keyboard_arrow_down,
//                     size: 27,
//                   ),
//                   iconEnabledColor:
//                       Theme.of(context).textSelectionTheme.selectionColor,
//                   dropdownColor: Theme.of(context).primaryColor,
//                   style: GoogleFonts.montserrat(fontSize: 16),
//                   items: ocorrenciasController.tipos
//                       .map((String dropDownStringItem) {
//                     return DropdownMenuItem<String>(
//                       value: dropDownStringItem,
//                       child: Text(dropDownStringItem),
//                     );
//                   }).toList(),
// onChanged: (String novoItemSelecionado) {
//   _dropDownItemSelected(novoItemSelecionado);
//   ocorrenciasController.itemSelecionado.value =
//       novoItemSelecionado;
// },
//                   value: ocorrenciasController.itemSelecionado.value,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 margin: EdgeInsets.all(7),
//                 child: customTextField(
//                   context,
//                   'Titulo',
//                   null,
//                   false,
//                   1,
//                   true,
//                   ocorrenciasController.title.value,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   showDatePicker(
//                     context: context,
//                     initialDate: data,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime(2024),
//                   ).then((value) => {
//                         setState(() {
//                           data = value;
//                           ocorrenciasController.date.value.text =
//                               (DateFormat("dd/MM/yyyy").format(value));
//                         })
//                       });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(7),
//                   child: customTextField(
//                     context,
//                     null,
//                     (DateFormat("dd/MM/yyyy").format(data)),
//                     false,
//                     1,
//                     false,
//                     ocorrenciasController.date.value,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   showTimePicker(
//                       context: context,
//                       initialTime: hora,
//                       builder: (BuildContext context, Widget child) {
//                         return MediaQuery(
//                             data: MediaQuery.of(context)
//                                 .copyWith(alwaysUse24HourFormat: true),
//                             child: child);
//                       }).then((value) => {
//                         setState(() {
//                           hora = value;
//                           ocorrenciasController.hour.value.text =
//                               value.format(context);
//                         })
//                       });
//                 },
//                 child: Container(
//                   margin: EdgeInsets.all(7),
//                   child: customTextField(
//                     context,
//                     null,
//                     hora.format(context),
//                     false,
//                     1,
//                     false,
//                     ocorrenciasController.hour.value,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 margin: EdgeInsets.all(7),
//                 child: customTextField(
//                   context,
//                   'Descrição',
//                   null,
//                   true,
//                   3,
//                   true,
//                   ocorrenciasController.description.value,
//                 ),
//               ),
//               Padding(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   child: ButtonTheme(
//                     height: 50.0,
//                     child: ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor:
//                             MaterialStateProperty.resolveWith<Color>(
//                           (Set<MaterialState> states) {
//                             return Theme.of(context)
//                                 .textSelectionTheme
//                                 .selectionColor;
//                           },
//                         ),
//                         elevation: MaterialStateProperty.resolveWith<double>(
//                             (Set<MaterialState> states) {
//                           return 3;
//                         }),
//                         shape:
//                             MaterialStateProperty.resolveWith<OutlinedBorder>(
//                           (Set<MaterialState> states) {
//                             return RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             );
//                           },
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "ANEXAR IMAGEM",
//                         style: GoogleFonts.montserrat(
//                             color: Theme.of(context).buttonColor, fontSize: 16),
//                       ),
//                     ),
//                   )),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                 child: ButtonTheme(
//                   height: 50.0,
//                   child: ElevatedButton(
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                           return Theme.of(context).accentColor;
//                         },
//                       ),
//                       elevation: MaterialStateProperty.resolveWith<double>(
//                           (Set<MaterialState> states) {
//                         return 3;
//                       }),
//                       shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
//                         (Set<MaterialState> states) {
//                           return RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           );
//                         },
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: ocorrenciasController.isLoading.value
//                         ? SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation(Colors.white),
//                             ),
//                           )
//                         : Text(
//                             "ENVIAR",
//                             style: GoogleFonts.montserrat(
//                                 color: Theme.of(context)
//                                     .textSelectionTheme
//                                     .selectionColor,
//                                 fontSize: 16),
//                           ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
