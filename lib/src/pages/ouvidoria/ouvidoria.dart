import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/controllers/ouvidoria/ouvidoria_controller.dart';

class Ouvidoria extends StatefulWidget {
  @override
  _OuvidoriaState createState() => _OuvidoriaState();
}

class _OuvidoriaState extends State<Ouvidoria> {
  OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ouvidoria',
            style: GoogleFonts.montserrat(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        'Assunto',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
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
                        isDense: true,
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
                        items: ouvidoriaController.assuntos
                            .map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String novoItemSelecionado) {
                          _dropDownItemSelected(novoItemSelecionado);
                          this.ouvidoriaController.itemSelecionado.value =
                              novoItemSelecionado;
                        },
                        value: ouvidoriaController.itemSelecionado.value,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    customTextField(
                      context,
                      "Mensagem",
                      null,
                      true,
                      5,
                      true,
                      ouvidoriaController.message.value,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
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
                            ouvidoriaController
                                .sendOuvidoria()
                                .then((response) {
                              if (response == 1) {
                                onAlertButtonPressed(
                                  context,
                                  'Enviado com sucesso!',
                                  null,
                                );
                                ouvidoriaController.isLoading.value = false;
                              } else if (response == 'vazio') {
                                onAlertButtonPressed(
                                    context,
                                    'Assunto e Mensagem são campos obrigátorios',
                                    null);
                                ouvidoriaController.isLoading.value = false;
                              } else {
                                onAlertButtonPressed(
                                  context,
                                  'Algo deu errado\n Tente novamente',
                                  null,
                                );
                                ouvidoriaController.isLoading.value = false;
                              }
                            });
                          },
                          child: ouvidoriaController.isLoading.value
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
                                context, '/visualizarOuvidoria');
                          },
                          child: Text(
                            "VISUALIZE MANIFESTAÇÕES",
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    ouvidoriaController.itemSelecionado.value = novoItem;
  }
}
