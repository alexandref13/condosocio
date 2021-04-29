import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/ocorrencias_controller.dart';
// import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

class Ocorrencias extends StatefulWidget {
  @override
  _OcorrenciasState createState() => _OcorrenciasState();
}

class _OcorrenciasState extends State<Ocorrencias> {
  OcorrenciasController ocorrenciasController =
      Get.put(OcorrenciasController());

  DateTime data = DateTime.now();
  TimeOfDay hora = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text('Ocorrências', style: GoogleFonts.montserrat(fontSize: 20)),
        ),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.all(15),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.all(7),
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
                        iconEnabledColor:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        dropdownColor: Theme.of(context).primaryColor,
                        style: GoogleFonts.montserrat(fontSize: 16),
                        items: ocorrenciasController.tipos
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String novoItemSelecionado) {
                          _dropDownItemSelected(novoItemSelecionado);
                          this.ocorrenciasController.itemSelecionado.value =
                              novoItemSelecionado;
                        },
                        value: ocorrenciasController.itemSelecionado.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    customTextField(
                      context,
                      'Titulo',
                      null,
                      false,
                      1,
                      true,
                      ocorrenciasController.title.value,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: data,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2024),
                        ).then((value) => {
                              setState(() {
                                data = value;
                                ocorrenciasController.date.value.text =
                                    (DateFormat("dd/MM/yyyy").format(value));
                              })
                            });
                      },
                      child: customTextField(
                        context,
                        null,
                        (DateFormat("dd/MM/yyyy").format(data)),
                        false,
                        1,
                        false,
                        ocorrenciasController.date.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showTimePicker(
                            context: context,
                            initialTime: hora,
                            builder: (BuildContext context, Widget child) {
                              return MediaQuery(
                                  data: MediaQuery.of(context)
                                      .copyWith(alwaysUse24HourFormat: true),
                                  child: child);
                            }).then((value) => {
                              setState(() {
                                hora = value;
                                ocorrenciasController.hour.value.text =
                                    value.format(context);
                              })
                            });
                      },
                      child: customTextField(
                        context,
                        null,
                        hora.format(context),
                        false,
                        1,
                        false,
                        ocorrenciasController.hour.value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: customTextField(
                        context,
                        'Descrição',
                        null,
                        true,
                        3,
                        true,
                        ocorrenciasController.description.value,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ButtonTheme(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {},
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
                          child: Text(
                            "ANEXAR IMAGEM",
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          onPressed: () {},
                          child: ocorrenciasController.isLoading.value
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : Text(
                                  "ENVIAR",
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontSize: 16),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            Navigator.pushNamed(
                                context, '/visualizarOcorrencias');
                          },
                          child: Text(
                            "VISUALIZE OCORRÊNCIAS",
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              })),
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    ocorrenciasController.itemSelecionado.value = novoItem;
  }
}
