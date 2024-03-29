import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
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
        return ouvidoriaController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
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
                            items: ouvidoriaController.assuntos
                                .map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String? novoItemSelecionado) {
                              _dropDownItemSelected(novoItemSelecionado!);
                              ouvidoriaController.itemSelecionado.value =
                                  novoItemSelecionado;
                            },
                            value: ouvidoriaController.itemSelecionado.value,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: customTextField(
                            context,
                            "Mensagem",
                            '',
                            true,
                            5,
                            1500,
                            true,
                            ouvidoriaController.message.value,
                          ),
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
                                ouvidoriaController.sendOuvidoria().then(
                                  (response) {
                                    if (response == 1) {
                                      confirmedButtonPressed(
                                        context,
                                        'Enviado com sucesso!',
                                        'ouvidoria',
                                      );
                                    } else if (response == 'vazio') {
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
                                "Enviar",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                ),
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
