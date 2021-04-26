import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/components/whatsapp_button_pressed.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/acessos/agenda_contatos_controller.dart';
import 'package:intl/intl.dart';

class ConviteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcessosController acessosController = Get.put(AcessosController());
    AgendaContatosController agendaContatosController =
        Get.put(AgendaContatosController());
    ConvitesController convitesController = Get.put(ConvitesController());
    LoginController loginController = Get.put(LoginController());

    void dropDownItemSelected(String novoItem) {
      acessosController.itemSelecionado.value = novoItem;
    }

    // void dropDownFavoriteSelected(String novoItem) {
    //   acessosController.firstId.value = novoItem;
    // }

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
                  padding: EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Nome do convite',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: customTextField(
                                context,
                                null,
                                'Convite de ${loginController.nome.value}',
                                true,
                                1,
                                true,
                                convitesController.inviteName.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Inicio do evento',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      convitesController
                                              .startSelectedDate.value =
                                          await convitesController
                                              .selectDateTime(context);
                                      if (convitesController
                                              .startSelectedDate.value ==
                                          null) return;
                                      convitesController
                                          .startSelectedDate.value = DateTime(
                                        convitesController
                                            .startSelectedDate.value.year,
                                        convitesController
                                            .startSelectedDate.value.month,
                                        convitesController
                                            .startSelectedDate.value.day,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 4),
                                      child: Text(
                                        convitesController.dateFormat
                                            .format(convitesController
                                                .startSelectedDate.value)
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      convitesController
                                              .startSelectedTime.value =
                                          await convitesController
                                              .selectTime(context);
                                      if (convitesController
                                              .startSelectedTime.value ==
                                          null) return;
                                      convitesController
                                          .startSelectedDate.value = DateTime(
                                        convitesController
                                            .startSelectedTime.value.hour,
                                        convitesController
                                            .startSelectedTime.value.minute,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 4),
                                      child: Text(
                                        '${convitesController.startSelectedTime.value.hour}:${convitesController.startSelectedTime.value.minute}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Text(
                              'Término do evento',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 20, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      convitesController.endSelectedDate.value =
                                          await convitesController
                                              .selectDateTime(context);
                                      if (convitesController
                                              .endSelectedDate.value ==
                                          null) return;
                                      convitesController.endSelectedDate.value =
                                          DateTime(
                                        convitesController
                                            .endSelectedDate.value.year,
                                        convitesController
                                            .endSelectedDate.value.month,
                                        convitesController
                                            .endSelectedDate.value.day,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 4),
                                      child: Text(
                                        convitesController.dateFormat
                                            .format(convitesController
                                                .endSelectedDate.value)
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      convitesController.endSelectedTime.value =
                                          await convitesController
                                              .selectTime(context);
                                      if (convitesController
                                              .endSelectedTime.value ==
                                          null) return;
                                      convitesController.endSelectedDate.value =
                                          DateTime(
                                        convitesController
                                            .endSelectedTime.value.hour,
                                        convitesController
                                            .endSelectedTime.value.minute,
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      margin: EdgeInsets.only(right: 4),
                                      child: Text(
                                        '${convitesController.endSelectedTime.value.hour}:${convitesController.endSelectedTime.value.minute}',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                        "INSIRA O NOME",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                'OU',
                                style: GoogleFonts.montserrat(fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 10,
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
                                        "PROCURAR NOS SEUS CONTATOS",
                                        style: GoogleFonts.montserrat(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 16),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      for (var i = 0;
                          i < convitesController.guestList.length;
                          i++)
                        Container(
                          margin: EdgeInsets.only(bottom: 12, top: 12),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${convitesController.guestList[i]['nome']} | ${convitesController.guestList[i]['tipo']} ',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                        Text(
                                          convitesController.guestList[i]
                                              ['tel'],
                                          style: GoogleFonts.montserrat(
                                            fontSize: 15,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () =>
                                    convitesController.guestList.removeAt(i),
                              )
                            ],
                          ),
                        ),
                      for (var i = 0; i < convitesController.count.value; i++)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
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
                              ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).accentColor;
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
                                    convitesController.handleAddGuestList();
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
                                          "ADICIONAR",
                                          style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontSize: 16),
                                        ),
                                ),
                              ),
                              ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).accentColor;
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
                                    convitesController.handleRemoveCount();
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
                                          "CANCELAR",
                                          style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontSize: 16),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                        acessosController.isLoading.value =
                                            false;
                                      } else if (value == 1) {
                                        onWhatsappButtonPressed(context, null);
                                        acessosController.isLoading.value =
                                            false;
                                      } else {
                                        onAlertButtonPressed(
                                          context,
                                          'Algo deu errado! \nTente novamente',
                                          null,
                                        );
                                        acessosController.isLoading.value =
                                            false;
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
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
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
                            acessosController.firstId.value != '0'
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ButtonTheme(
                                        height: 50.0,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
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
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}

//  Container(
//                                 padding: EdgeInsets.all(7),
//                                 margin: EdgeInsets.only(
//                                     top: 10, bottom: 20, left: 10, right: 10),
//                                 height: 55,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                     color: Theme.of(context)
//                                         .textSelectionTheme
//                                         .selectionColor,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: DropdownButton<String>(
//                                   autofocus: false,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   icon: Icon(
//                                     Icons.keyboard_arrow_down,
//                                     size: 27,
//                                   ),
//                                   iconEnabledColor: Theme.of(context)
//                                       .textSelectionTheme
//                                       .selectionColor,
//                                   dropdownColor: Theme.of(context).primaryColor,
//                                   style: GoogleFonts.montserrat(fontSize: 16),
//                                   items: acessosController.fav.map((item) {
//                                     return DropdownMenuItem(
//                                       value: item['id'].toString(),
//                                       child: Text(item['pessoa']),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String novoItemSelecionado) {
//                                     dropDownFavoriteSelected(
//                                         novoItemSelecionado);
//                                     acessosController.firstId.value =
//                                         novoItemSelecionado;
//                                     acessosController.firstId.value != '0'
//                                         ? acessosController.getAFavorite()
//                                         : acessosController.cleanController();
//                                   },
//                                   value: acessosController.firstId.value,
//                                 ),
//                               ),
