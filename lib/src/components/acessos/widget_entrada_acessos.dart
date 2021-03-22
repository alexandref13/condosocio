import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EntradaAcessos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcessosController acessosController = Get.put(AcessosController());
    VisualizarAcessosController visualizarAcessosController =
        Get.put(VisualizarAcessosController());

    void dropDownItemSelected(String novoItem) {
      acessosController.itemSelecionado.value = novoItem;
    }

    void dropDownFavoriteSelected(String novoItem) {
      acessosController.firstId.value = novoItem;
    }

    return Obx(
      () {
        return acessosController.isLoading.value
            ? Container(
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      valueColor:
                          AlwaysStoppedAnimation(Theme.of(context).accentColor),
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 55,
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
                          autofocus: false,
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
                          style: GoogleFonts.montserrat(fontSize: 16),
                          items: acessosController.fav.map((item) {
                            return DropdownMenuItem(
                              value: item['id'].toString(),
                              child: Text(item['pessoa']),
                            );
                          }).toList(),
                          onChanged: (String novoItemSelecionado) {
                            dropDownFavoriteSelected(novoItemSelecionado);
                            acessosController.firstId.value =
                                novoItemSelecionado;
                            acessosController.firstId.value != '0'
                                ? acessosController.getAFavorite()
                                : acessosController.cleanController();
                          },
                          value: acessosController.firstId.value,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'OU',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonTheme(
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
                              },
                            ),
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
                          child: acessosController.isLoading.value
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : Text(
                                  "PROCURAR NOS SEUS CONTATOS",
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 55,
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
                          iconEnabledColor: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          dropdownColor: Theme.of(context).primaryColor,
                          style: GoogleFonts.montserrat(fontSize: 16),
                          items: acessosController.tipos
                              .map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String novoItemSelecionado) {
                            dropDownItemSelected(novoItemSelecionado);
                            acessosController.itemSelecionado.value =
                                novoItemSelecionado;
                          },
                          value: acessosController.itemSelecionado.value,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(
                        context,
                        'Nome ou empresa',
                        null,
                        false,
                        1,
                        true,
                        acessosController.name.value,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      customTextField(context, 'Celular', null, false, 1, true,
                          acessosController.phone.value),
                      SizedBox(
                        height: 20,
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
                              },
                            ),
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
                            acessosController.sendAcessos().then(
                              (value) {
                                if (value == 'vazio') {
                                  onAlertButtonPressed(
                                      context,
                                      'Tipo de visitante, nome e celular são campos obrigátorios!',
                                      null);
                                  acessosController.isLoading.value = false;
                                } else if (value == 1) {
                                  onAlertButtonPressed(
                                      context, 'Acesso autorizado!', null);
                                  acessosController.isLoading.value = false;
                                } else {
                                  onAlertButtonPressed(
                                      context,
                                      'Algo deu errado! \nTente novamente',
                                      null);
                                  acessosController.isLoading.value = false;
                                }
                              },
                            );
                            acessosController.name.value.text = '';
                            acessosController.phone.value.text = '';
                            acessosController.firstId.value = '0';
                          },
                          child: acessosController.isLoading.value
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                )
                              : Text(
                                  "AUTORIZAR",
                                  style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontSize: 16),
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonTheme(
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
                              },
                            ),
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
                            Get.toNamed('/visualizarAcessos');
                          },
                          child: Text(
                            "VISUALIZE ACESSOS",
                            style: GoogleFonts.montserrat(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      acessosController.firstId.value != '0'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                ButtonTheme(
                                  height: 50.0,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          return Colors.red;
                                        },
                                      ),
                                      elevation: MaterialStateProperty
                                          .resolveWith<double>(
                                        (Set<MaterialState> states) {
                                          return 3;
                                        },
                                      ),
                                      shape: MaterialStateProperty.resolveWith<
                                          OutlinedBorder>(
                                        (Set<MaterialState> states) {
                                          return RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          );
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      acessosController.deleteFav().then(
                                        (value) {
                                          if (value == 1) {
                                            onAlertButtonPressed(
                                              context,
                                              'Favorito deletado!',
                                              '/home',
                                            );
                                          } else {
                                            onAlertButtonPressed(
                                              context,
                                              'Algo deu errado \n Tente novamente',
                                              '/home',
                                            );
                                          }
                                        },
                                      );
                                    },
                                    child: Text(
                                      "APAGAR FAVORITO",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.black, fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
