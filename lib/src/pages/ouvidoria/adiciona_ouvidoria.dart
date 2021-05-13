import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/controllers/ouvidoria/ouvidoria_controller.dart';

class AdicionaOuvidoria extends StatefulWidget {
  @override
  _AdicionaOuvidoriaState createState() => _AdicionaOuvidoriaState();
}

class _AdicionaOuvidoriaState extends State<AdicionaOuvidoria> {
  OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());

  void _dropDownItemSelected(String novoItem) {
    ouvidoriaController.itemSelecionado.value = novoItem;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(7),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
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
                  Container(
                    margin: EdgeInsets.all(7),
                    child: customTextField(
                      context,
                      "Mensagem",
                      null,
                      true,
                      5,
                      true,
                      ouvidoriaController.message.value,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                          elevation: MaterialStateProperty.resolveWith<double>(
                              (Set<MaterialState> states) {
                            return 3;
                          }),
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
                          ouvidoriaController.sendOuvidoria().then((response) {
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
