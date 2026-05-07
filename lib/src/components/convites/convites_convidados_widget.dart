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

class ConvitesConvidadosWidget extends StatefulWidget {
  const ConvitesConvidadosWidget({Key? key}) : super(key: key);

  @override
  State<ConvitesConvidadosWidget> createState() =>
      _ConvitesConvidadosWidgetState();
}

class _ConvitesConvidadosWidgetState extends State<ConvitesConvidadosWidget> {
  bool _didShowInfoDialog = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      if (!_didShowInfoDialog &&
          !convitesController.isLoading.value &&
          !acessosController.isLoading.value) {
        _didShowInfoDialog = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showInfoDialog(context);
          }
        });
      }

      return convitesController.isLoading.value ||
              acessosController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: _buildInfoTrigger(context),
                    ),
                    SizedBox(
                      height: 14,
                    ),
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
                                  onChanged:
                                      (String? novoItemSelecionado) async {
                                    dropDownFavoriteSelected(
                                        novoItemSelecionado!);
                                    acessosController.firstId.value =
                                        novoItemSelecionado;
                                    if (acessosController.firstId.value !=
                                        '0') {
                                      final result = await convitesController
                                          .getAFavorite();
                                      if (result == 'duplicate_phone') {
                                        _showDuplicatePhoneAlert(context);
                                      }
                                    } else {
                                      acessosController.cleanController();
                                    }
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
                            onTap: () async {
                              final result =
                                  await agendaContatosController.pickContact();
                              if (result == 'duplicate_phone') {
                                _showDuplicatePhoneAlert(context);
                              }
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
                                      onPressed: () async {
                                        final result =
                                            await agendaContatosController
                                                .pickContact();
                                        if (result == 'duplicate_phone') {
                                          _showDuplicatePhoneAlert(context);
                                        }
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
                                    onPressed: () async {
                                      final result =
                                          await agendaContatosController
                                              .pickContact();
                                      if (result == 'duplicate_phone') {
                                        _showDuplicatePhoneAlert(context);
                                      }
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
                                                    .colorScheme
                                                    .error;
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
                                                          .colorScheme
                                                          .error),
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
                                                      .colorScheme
                                                      .error;
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
                                                final result =
                                                    convitesController
                                                        .handleAddGuestList();
                                                if (result ==
                                                    'duplicate_phone') {
                                                  _showDuplicatePhoneAlert(
                                                      context);
                                                }
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
                                      final status =
                                          value is Map ? (value['status'] ?? 0) : value;
                                      final idconv = value is Map
                                          ? (value['idconv'] ?? 0).toString()
                                          : value.toString();

                                      if (status == 1) {
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
                                                .getAConvite(idconv);
                                            Get.back();
                                          },
                                        );
                                      } else if (status == 2) {
                                        onAlertButtonPressed(
                                            context,
                                            'Esse convidado já possui registro de entrada ou saída e não pode ser excluído.',
                                            '',
                                            'images/error.png');
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

  Widget _buildInfoTrigger(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _showInfoDialog(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(.12),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).colorScheme.secondary,
              size: 20,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Como adicionar múltiplos convidados',
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 18, 20, 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Como adicionar seus convidados',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(dialogContext).pop(),
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                _buildInfoCard(context),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Text(
                      'Fechar',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    final textColor = Theme.of(context).textSelectionTheme.selectionColor!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem(
            context,
            'Você pode inserir múltiplos convidados na mesma autorização.',
          ),
          _buildInfoItem(
            context,
            'Escolha um favorito, busque nos contatos ou adicione manualmente quantas pessoas precisar.',
          ),
          _buildInfoItem(
            context,
            'Para enviar o convite pelo WhatsApp, use a opção Procurar nos contatos.',
          ),
          _buildInfoItem(
            context,
            'Se você não tiver o telefone do convidado, use Adicione um convidado. Nesse caso, o sistema não enviará o convite, apenas liberará a autorização para a portaria.',
          ),
          _buildInfoItem(
            context,
            'Se for corrida por app, use a opção App mobilidade e informe nome do motorista e placa.',
          ),
          _buildInfoItem(
            context,
            'Confira a lista criada abaixo e toque em AUTORIZAR quando terminar.',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3, right: 8),
            child: Icon(
              Icons.check_circle_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                height: 1.45,
                color: Theme.of(context)
                    .textSelectionTheme
                    .selectionColor!
                    .withOpacity(.92),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDuplicatePhoneAlert(BuildContext context) {
    onAlertButtonPressed(
      context,
      'Já existe um convidado com esse celular na lista.',
      '/home',
      'images/error.png',
    );
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
