import 'package:condosocio/src/components/utils/alertInvite.dart';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/acessos/agenda_contatos_controller.dart';

class ConvitesConvidadosWidget extends StatelessWidget {
  const ConvitesConvidadosWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AcessosController acessosController = Get.put(AcessosController());
    AgendaContatosController agendaContatosController =
        Get.put(AgendaContatosController());
    ConvitesController convitesController = Get.put(ConvitesController());
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());
    LoginController loginController = Get.put(LoginController());

    void dropDownItemSelected(String novoItem) {
      acessosController.itemSelecionado.value = novoItem;
    }

    void dropDownFavoriteSelected(String novoItem) {
      acessosController.firstId.value = novoItem;
    }

    return Obx(() {
      return convitesController.isLoading.value ||
              acessosController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 20),
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
                                      .selectionColor!),
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
                                onPressed: () {},
                                child: DropdownButton<String>(
                                  autofocus: false,
                                  isExpanded: true,
                                  underline: Container(),
                                  icon: Icon(Icons.keyboard_arrow_right,
                                      size: 27,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                  dropdownColor: Theme.of(context).primaryColor,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                  items: acessosController.fav.map((item) {
                                    return DropdownMenuItem(
                                      value: item['id'].toString(),
                                      child: Text(item['pessoa']),
                                    );
                                  }).toList(),
                                  onChanged: (String? novoItemSelecionado) {
                                    dropDownFavoriteSelected(
                                        novoItemSelecionado!);
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
                                      .selectionColor!),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              agendaContatosController.pickContact();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonTheme(
                                    height: 50.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Theme.of(context)
                                                .primaryColor;
                                          },
                                        ),
                                        elevation: MaterialStateProperty
                                            .resolveWith<double>(
                                          (Set<MaterialState> states) {
                                            return 0;
                                          },
                                        ),
                                        shape: MaterialStateProperty
                                            .resolveWith<OutlinedBorder>(
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
                                      child: Text(
                                        "Procurar nos contatos",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 27,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                    onPressed: () {
                                      agendaContatosController.pickContact();
                                    },
                                  )
                                ],
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
                                      .selectionColor!),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              convitesController.handleAddCount();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonTheme(
                                    height: 50.0,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            return Theme.of(context)
                                                .primaryColor;
                                          },
                                        ),
                                        elevation: MaterialStateProperty
                                            .resolveWith<double>(
                                          (Set<MaterialState> states) {
                                            return 0;
                                          },
                                        ),
                                        shape: MaterialStateProperty
                                            .resolveWith<OutlinedBorder>(
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
                                      child: Text(
                                        "Adicione um convidado",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      convitesController.count.value
                                          ? Icons.keyboard_arrow_down
                                          : Icons.keyboard_arrow_right,
                                      size: 27,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                    onPressed: () {
                                      convitesController.handleAddCount();
                                    },
                                  )
                                ],
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
                                      .selectionColor!),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              convitesController.handleAddCountApp();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ButtonTheme(
                                      height: 50.0,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty
                                              .resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                              return Theme.of(context)
                                                  .primaryColor;
                                            },
                                          ),
                                          elevation: MaterialStateProperty
                                              .resolveWith<double>(
                                            (Set<MaterialState> states) {
                                              return 0;
                                            },
                                          ),
                                          shape: MaterialStateProperty
                                              .resolveWith<OutlinedBorder>(
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
                                              .handleAddCountApp();
                                        },
                                        child: Text(
                                          "App mobilidade",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        convitesController.countApp.value
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_right,
                                        size: 27,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                      onPressed: () {
                                        convitesController.handleAddCountApp();
                                      },
                                    )
                                  ],
                                )),
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
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: customTextField(
                                    context,
                                    '',
                                    'Nome do motorista',
                                    true,
                                    1,
                                    30,
                                    true,
                                    acessosController.name.value,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: customTextField(
                                    context,
                                    '',
                                    'Placa do veículo',
                                    true,
                                    1,
                                    7,
                                    true,
                                    convitesController.carBoard.value,
                                  ),
                                ),
                                /*Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.all(7),
                                  child: TextField(
                                    onTap: () {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus &&
                                          currentFocus.focusedChild != null) {
                                        currentFocus.focusedChild!.unfocus();
                                      }
                                    },
                                    enableSuggestions: false,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    maxLength: 7,
                                    controller:
                                        convitesController.carBoard.value,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                    decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1,
                                        ),
                                      ),
                                      enabled: true,
                                      labelText: 'Placa do carro',
                                      labelStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                      isDense: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/
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
                                                          .selectionColor!,
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
                                                    .colorScheme
                                                    .secondary;
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
                                                  '',
                                                  'images/error.png');
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
                                                          .selectionColor!,
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
                                      'Adicione um Convidado',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!),
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
                                    onChanged: (String? novoItemSelecionado) {
                                      dropDownItemSelected(
                                          novoItemSelecionado!);
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
                                    '',
                                    'Nome ou empresa',
                                    true,
                                    1,
                                    30,
                                    true,
                                    acessosController.name.value,
                                  ),
                                ),
                                /* Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  padding: EdgeInsets.all(7),
                                  child: TextField(
                                    controller: acessosController.phone.value,
                                    inputFormatters: [
                                      convitesController.maskFormatter
                                    ],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                    decoration: InputDecoration(
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1,
                                        ),
                                      ),
                                      labelText: 'Celular',
                                      labelStyle: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                      isDense: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 2,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),*/
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
                                                            .selectionColor!,
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
                                                      .colorScheme
                                                      .secondary;
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
                                                    '',
                                                    'images/error.png');
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
                                                            .selectionColor!,
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
                                  .selectionColor!,
                            )),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Icon(
                                convitesController.guestList[i]['placa'] == null
                                    ? Icons.account_circle_outlined
                                    : Icons.directions_car_outlined,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                size: 30,
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .44,
                                    child: Text(
                                      convitesController.guestList[i]['nome'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                    ),
                                  ),
                                  convitesController.guestList[i]['tel'] != null
                                      ? Text(
                                          convitesController.guestList[i]
                                              ['tel'],
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        )
                                      : convitesController.guestList[i]
                                                  ['placa'] !=
                                              null
                                          ? Text(
                                              convitesController.guestList[i]
                                                      ['placa']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            )
                                          : Container(),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                size: 28,
                              ),
                              onPressed: () =>
                                  convitesController.guestList.removeAt(i),
                            )
                          ],
                        ),
                      ),
                    convitesController.guestList.length != 0
                        ? Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 12),
                            width: MediaQuery.of(context).size.width,
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
                                  if (convitesController.isEdited.value) {
                                    print('PEGOU EDIÇÃO');
                                    convitesController
                                        .editAInvite()
                                        .then((value) {
                                      if (value != 0) {
                                        acessosController.getAcessos();
                                        convitesController.guestList.clear();
                                        convitesController.getConvites();
                                        visualizarConvitesController
                                                .endDate.value =
                                            convitesController.endDate.value;
                                        visualizarConvitesController
                                                .qtdconv.value =
                                            convitesController.guestList.length;
                                        if (convitesController
                                                .inviteName.value.text ==
                                            '') {
                                          visualizarConvitesController
                                                  .titulo.value =
                                              'Convite de ${loginController.nome.value}';
                                        } else {
                                          visualizarConvitesController
                                                  .titulo.value =
                                              convitesController
                                                  .inviteName.value.text;
                                        }
                                        confirmedInviteAlert(
                                          context,
                                          'Seu convite foi incluído com sucesso!Para agilizar o acesso envie via Whatsapp o link do convite para cada um dos seus convidados',
                                          'images/bannerwhat.png',
                                          'Fechar',
                                          () {
                                            visualizarConvitesController
                                                .getAConvite(value.toString());
                                            Get.back();
                                          },
                                        );
                                      } else {
                                        onAlertButtonPressed(
                                            context,
                                            'Algo deu errado \n Tente novamente',
                                            '/home',
                                            'images/error.png');
                                      }
                                    });
                                  } else {
                                    print('PEGOU INVITE');
                                    convitesController
                                        .sendConvites(
                                      convitesController.startDate.value,
                                      convitesController.endDate.value,
                                      convitesController.isChecked.value,
                                    )
                                        .then(
                                      (value) {
                                        print(
                                            'Retorno Dados do convites_inc.php $value');
                                        if (value != 0) {
                                          convitesController.guestList.clear();

                                          convitesController.getConvites();

                                          visualizarConvitesController
                                                  .endDate.value =
                                              convitesController.endDate.value;
                                          visualizarConvitesController
                                                  .qtdconv.value =
                                              convitesController
                                                  .guestList.length;

                                          if (convitesController
                                                  .inviteName.value.text ==
                                              '') {
                                            visualizarConvitesController
                                                    .titulo.value =
                                                'Convite de ${loginController.nome.value}';
                                          } else {
                                            visualizarConvitesController
                                                    .titulo.value =
                                                convitesController
                                                    .inviteName.value.text;
                                          }
                                          visualizarConvitesController
                                              .idConv.value = value.toString();

                                          confirmedInviteAlert(
                                            context,
                                            'Seu convite foi incluído com sucesso!Para agilizar o acesso envie via Whatsapp o link do convite para cada um dos seus convidados',
                                            'images/bannerwhat.png',
                                            'Fechar',
                                            () {
                                              visualizarConvitesController
                                                  .getAConvite(
                                                      value.toString());
                                              Get.back();
                                            },
                                          );
                                        } else {
                                          onAlertButtonPressed(
                                              context,
                                              'Algo deu errado \n Tente novamente',
                                              '/home',
                                              'images/error.png');
                                        }
                                      },
                                    );
                                    acessosController.firstId.value = '0';
                                  }
                                },
                                child: Text(
                                  'AUTORIZAR',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
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

  /* confirmedInviteAlert(context, String text, VoidCallback onTap) {
    Alert(
      image: Image.asset(
        'images/bannerwhat.png',
        height: 300,
      ),
      style: AlertStyle(
        backgroundColor: Theme.of(context).textSelectionTheme.selectionColor!,
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        animationDuration: Duration(milliseconds: 300),
        titleStyle: GoogleFonts.poppins(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 16,
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
          onPressed: onTap,
          width: 80,
          color: Colors.green,
        )
      ],
    ).show();
  }*/
}
