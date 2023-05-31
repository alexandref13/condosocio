import 'dart:io';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/ocorrencias/ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

import '../../components/utils/confirmed_button_pressed.dart';

class AdicionarOcorrencias extends StatefulWidget {
  const AdicionarOcorrencias({Key? key}) : super(key: key);

  @override
  _AdicionarOcorrenciasState createState() => _AdicionarOcorrenciasState();
}

class _AdicionarOcorrenciasState extends State<AdicionarOcorrencias> {
  OcorrenciasController ocorrenciasController =
      Get.put(OcorrenciasController());
  var startSelectedDate = DateTime.now();
  var startSelectedTime = TimeOfDay.now();

  Future<TimeOfDay?> selectTime(BuildContext context) {
    final now = DateTime.now();
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
  }

  Future<DateTime?> selectDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(Duration(seconds: 1)),
      );

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
              color: Theme.of(context).colorScheme.secondary,
              padding: EdgeInsets.only(bottom: 30),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      title: Center(
                          child: Text(
                    "Anexar Imagem",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                  ))),
                  Divider(
                    height: 20,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                  ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                    ),
                    title: new Text(
                      'Câmera',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                      ),
                    ),
                    trailing: new Icon(
                      Icons.arrow_right,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
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
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!),
                    title: new Text(
                      'Galeria',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                      ),
                    ),
                    trailing: new Icon(Icons.arrow_right,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!),
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
                          style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              fontSize: 14),
                          items: ocorrenciasController.tipos
                              .map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String? novoItemSelecionado) {
                            _dropDownItemSelected(novoItemSelecionado!);
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
                          '',
                          'Titulo',
                          false,
                          1,
                          true,
                          ocorrenciasController.title.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          startSelectedDate = (await selectDateTime(context))!;
                          if (startSelectedDate == null) return;

                          setState(() {
                            startSelectedDate = DateTime(
                              startSelectedDate.year,
                              startSelectedDate.month,
                              startSelectedDate.day,
                            );
                          });
                          ocorrenciasController.date.value.text =
                              DateFormat('dd/MM/yyyy')
                                  .format(startSelectedDate);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: customTextField(
                            context,
                            'Data do Ocorrido',
                            '',
                            false,
                            1,
                            false,
                            ocorrenciasController.date.value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          startSelectedTime = (await selectTime(context))!;
                          if (startSelectedTime == null) return;
                          setState(() {
                            startSelectedDate = DateTime(
                                startSelectedDate.year,
                                startSelectedDate.month,
                                startSelectedDate.day,
                                startSelectedTime.hour,
                                startSelectedTime.minute);
                          });
                          ocorrenciasController.hour.value.text =
                              DateFormat('HH:mm').format(startSelectedDate);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: customTextField(
                            context,
                            'Hora',
                            '',
                            false,
                            1,
                            false,
                            ocorrenciasController.hour.value,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: customTextField(
                          context,
                          '',
                          'Descrição',
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
                                ocorrenciasSaidaModalBottomSheet();
                              },
                              child: Text(
                                "Anexar Imagem",
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
                                ocorrenciasController
                                    .sendOcorrencia(
                                  selectedFile == null
                                      ? ''
                                      : selectedFile!.path,
                                )
                                    .then((value) {
                                  if (value == 'vazio') {
                                    onAlertButtonPressed(
                                        context,
                                        'Campo Obrigatório Vazio',
                                        '',
                                        'images/error.png');
                                  } else if (value == '1') {
                                    confirmedButtonPressed(
                                      context,
                                      'Sua Ocorrência foi Enviada com Sucesso!',
                                      'ocorrencias',
                                    );
                                  } else {
                                    onAlertButtonPressed(
                                        context,
                                        'Houve algum problema!\n Tente novamente',
                                        '/home',
                                        'images/error.png');
                                  }
                                });
                              },
                              child: Text(
                                "Enviar",
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
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
