import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/components/confirmed_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/acessos/agenda_contatos_controller.dart';

class ConvitesConvidadosWidget extends StatelessWidget {
  const ConvitesConvidadosWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AcessosController acessosController = Get.put(AcessosController());
    AgendaContatosController agendaContatosController =
        Get.put(AgendaContatosController());
    ConvitesController convitesController = Get.put(ConvitesController());

    void dropDownItemSelected(String novoItem) {
      acessosController.itemSelecionado.value = novoItem;
    }

    void dropDownFavoriteSelected(String novoItem) {
      acessosController.firstId.value = novoItem;
    }

    return Obx(() {
      return convitesController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).primaryColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 0;
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
                                  convitesController.handleAddCountApp();
                                },
                                child: DropdownButton<String>(
                                  autofocus: false,
                                  underline: Container(),
                                  icon: Container(),
                                  dropdownColor: Theme.of(context).primaryColor,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor),
                                  items: acessosController.fav.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['pessoa']),
                                    );
                                  }).toList(),
                                  onChanged: (String novoItemSelecionado) {
                                    dropDownFavoriteSelected(
                                        novoItemSelecionado);
                                    acessosController.firstId.value =
                                        novoItemSelecionado;
                                    acessosController.firstId.value != '0'
                                        ? convitesController.getAFavorite()
                                        : acessosController.cleanController();
                                  },
                                  value: acessosController.firstId.value,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'OU',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).primaryColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 0;
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
                                  convitesController.handleAddCountApp();
                                },
                                child: acessosController.isLoading.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text(
                                        "App Mobilidade",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'OU',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).primaryColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 0;
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
                                  convitesController.handleAddCount();
                                },
                                child: acessosController.isLoading.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text(
                                        "Adicione um convidado",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'OU',
                              style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ButtonTheme(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      return Theme.of(context).primaryColor;
                                    },
                                  ),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    (Set<MaterialState> states) {
                                      return 0;
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
                                  agendaContatosController.pickContact();
                                },
                                child: acessosController.isLoading.value
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                    : Text(
                                        "Procurar nos contatos",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    convitesController.countApp.value
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20, left: 10, right: 10),
                                  child: Center(
                                    child: Text(
                                      'App Mobilidade',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: customTextField(
                                    context,
                                    'Nome do motorista',
                                    null,
                                    false,
                                    1,
                                    true,
                                    acessosController.name.value,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.all(7),
                                  child: customTextField(
                                    context,
                                    'Placa do carro',
                                    null,
                                    false,
                                    1,
                                    true,
                                    convitesController.carBoard.value,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ButtonTheme(
                                        height: 50.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                return Theme.of(context)
                                                    .errorColor;
                                              },
                                            ),
                                            elevation: MaterialStateProperty
                                                .resolveWith<double>(
                                              (Set<MaterialState> states) {
                                                return 3;
                                              },
                                            ),
                                            shape: MaterialStateProperty
                                                .resolveWith<OutlinedBorder>(
                                              (Set<MaterialState> states) {
                                                return RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: Theme.of(context)
                                                          .errorColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                );
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            acessosController.name.value.text =
                                                '';
                                            convitesController
                                                .carBoard.value.text = '';
                                            convitesController
                                                .handleRemoveCountApp();
                                          },
                                          child: acessosController
                                                  .isLoading.value
                                              ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.white),
                                                  ),
                                                )
                                              : Text(
                                                  "Cancelar",
                                                  style: GoogleFonts.montserrat(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontSize: 14),
                                                ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: ButtonTheme(
                                        height: 50.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                return Theme.of(context)
                                                    .accentColor;
                                              },
                                            ),
                                            elevation: MaterialStateProperty
                                                .resolveWith<double>(
                                              (Set<MaterialState> states) {
                                                return 3;
                                              },
                                            ),
                                            shape: MaterialStateProperty
                                                .resolveWith<OutlinedBorder>(
                                              (Set<MaterialState> states) {
                                                return RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                );
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            if (acessosController
                                                        .name.value.text ==
                                                    '' ||
                                                convitesController
                                                        .carBoard.value.text ==
                                                    '') {
                                              onAlertButtonPressed(
                                                context,
                                                'Campo nome ou placa vazio!',
                                                null,
                                              );
                                            } else {
                                              convitesController
                                                  .handleAddAppList();
                                            }
                                          },
                                          child: acessosController
                                                  .isLoading.value
                                              ? SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            Colors.white),
                                                  ),
                                                )
                                              : Text(
                                                  "Adicionar",
                                                  style: GoogleFonts.montserrat(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontSize: 14),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : Container(),
                    convitesController.count.value
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20, left: 10, right: 10),
                                  child: Center(
                                    child: Text(
                                      'Convidado',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 7),
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
                                    dropdownColor:
                                        Theme.of(context).primaryColor,
                                    style: GoogleFonts.montserrat(fontSize: 14),
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
                                    value:
                                        acessosController.itemSelecionado.value,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7),
                                  padding: EdgeInsets.all(7),
                                  child: customTextField(
                                    context,
                                    'Nome ou empresa',
                                    null,
                                    false,
                                    1,
                                    true,
                                    acessosController.name.value,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.all(7),
                                  child: customTextField(
                                    context,
                                    'Celular (ex: 91 989900290)',
                                    null,
                                    false,
                                    1,
                                    true,
                                    acessosController.phone.value,
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: ButtonTheme(
                                          height: 50.0,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Theme.of(context)
                                                      .errorColor;
                                                },
                                              ),
                                              elevation: MaterialStateProperty
                                                  .resolveWith<double>(
                                                (Set<MaterialState> states) {
                                                  return 3;
                                                },
                                              ),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (Set<MaterialState> states) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () {
                                              convitesController
                                                  .handleRemoveCount();
                                            },
                                            child: acessosController
                                                    .isLoading.value
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Colors.white),
                                                    ),
                                                  )
                                                : Text(
                                                    "Cancelar",
                                                    style: GoogleFonts.montserrat(
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                        fontSize: 14),
                                                  ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: ButtonTheme(
                                          height: 50.0,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  return Theme.of(context)
                                                      .accentColor;
                                                },
                                              ),
                                              elevation: MaterialStateProperty
                                                  .resolveWith<double>(
                                                (Set<MaterialState> states) {
                                                  return 3;
                                                },
                                              ),
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (Set<MaterialState> states) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  );
                                                },
                                              ),
                                            ),
                                            onPressed: () {
                                              if (acessosController
                                                          .name.value.text ==
                                                      '' ||
                                                  acessosController
                                                          .itemSelecionado
                                                          .value ==
                                                      'Selecione o tipo de visitante') {
                                                onAlertButtonPressed(
                                                  context,
                                                  'Campo nome ou tipo de visitante vazio!',
                                                  null,
                                                );
                                              } else {
                                                convitesController
                                                    .handleAddGuestList();
                                              }
                                            },
                                            child: acessosController
                                                    .isLoading.value
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Colors.white),
                                                    ),
                                                  )
                                                : Text(
                                                    "Adicionar",
                                                    style: GoogleFonts.montserrat(
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                        fontSize: 14),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ])
                              ],
                            ),
                          )
                        : Container(),
                    for (var i = 0;
                        i < convitesController.guestList.length;
                        i++)
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            )),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(Feather.user_check),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${convitesController.guestList[i]['nome']} | ${convitesController.guestList[i]['tipo']} ',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      convitesController.guestList[i]['tel'] !=
                                              null
                                          ? Text(
                                              convitesController.guestList[i]
                                                  ['tel'],
                                              style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            )
                                          : Container(
                                              child: convitesController
                                                              .guestList[i]
                                                          ['placa'] !=
                                                      null
                                                  ? Text(
                                                      convitesController
                                                          .guestList[i]['placa']
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                                    )
                                                  : Container(),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete,
                                  color: Theme.of(context).errorColor),
                              onPressed: () =>
                                  convitesController.guestList.removeAt(i),
                            )
                          ],
                        ),
                      ),
                    convitesController.guestList.length != 0
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: MediaQuery.of(context).size.width,
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
                                      return 2;
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
                                  convitesController
                                      .sendConvites(
                                    convitesController.startDate.value,
                                    convitesController.endDate.value,
                                  )
                                      .then(
                                    (value) {
                                      if (value == 1) {
                                        confirmedButtonPressed(
                                            context,
                                            'Seu convite foi enviado com sucesso!',
                                            '/home');
                                      } else {
                                        confirmedButtonPressed(
                                          context,
                                          'Algo deu errado \n Tente novamente',
                                          '/home',
                                        );
                                      }
                                    },
                                  );
                                  acessosController.firstId.value = '0';
                                },
                                child: Text(
                                  'AUTORIZAR',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            );
    });
  }
}