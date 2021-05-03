import 'dart:convert';

import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetalheConviteWidget extends StatelessWidget {
  const DetalheConviteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());
    ConvitesController convitesController = Get.put(ConvitesController());

    var endDate = DateTime.parse(visualizarConvitesController.endDate.value);

    var formatEndDateDay = DateFormat("dd/MM/yyyy").format(
      endDate,
    );
    var formatEndDateHour = DateFormat("HH:mm").format(
      endDate,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(visualizarConvitesController.titulo.value),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: visualizarConvitesController.invite.length,
          itemBuilder: (_, i) {
            var invite = visualizarConvitesController.invite[i];

            var convidados = json.decode(invite['convidados']);

            visualizarConvitesController.convidados.assignAll(convidados);

            var startDate = invite['datainicial'];
            visualizarConvitesController.startDate.value = startDate;
            var formatStartDate = startDate.split(' ');

            var formatStartDateDay = formatStartDate[0];
            var formatStartDateHour = formatStartDate[1];

            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    'Início',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Feather.calendar,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      size: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        formatStartDateDay,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 30,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                size: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  formatStartDateHour,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    'Término',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Feather.calendar,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      size: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        formatEndDateDay,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                size: 20,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  formatEndDateHour,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  for (var x = 0; x < convidados.length; x++)
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${convidados[x]['nome']}',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                    ),
                                    convidados[x]['tel'] != null
                                        ? Text(
                                            convidados[x]['tel'],
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          )
                                        : Container(
                                            child: convidados[x]['placa'] !=
                                                    null
                                                ? Text(
                                                    convidados[x]['placa']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style:
                                                        GoogleFonts.montserrat(
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
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  FontAwesome.whatsapp,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Theme.of(context).errorColor,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border(
            top: BorderSide(
              width: .5,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: ButtonTheme(
                  height: 70,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context).errorColor;
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 0;
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            side:
                                BorderSide(color: Theme.of(context).errorColor),
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Deletar",
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
                  height: 70,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context).accentColor;
                        },
                      ),
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 0;
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          );
                        },
                      ),
                    ),
                    onPressed: () {
                      convitesController.isEdited.value = true;
                      for (var i = 0;
                          i < visualizarConvitesController.convidados.length;
                          i++) {
                        convitesController.guestList.addAll({
                          {
                            'nome': visualizarConvitesController.convidados[i]
                                ['nome'],
                            'tel': visualizarConvitesController.convidados[i]
                                ['tel'],
                            'tipo': visualizarConvitesController.convidados[i]
                                ['tipo'],
                            'placa': visualizarConvitesController.convidados[i]
                                ['placa'],
                          }
                        });
                      }
                      convitesController.inviteName.value.text =
                          visualizarConvitesController.titulo.value;
                      convitesController.startDate.value =
                          visualizarConvitesController.startDate.value;
                      convitesController.endDate.value =
                          visualizarConvitesController.endDate.value;

                      convitesController.page.value = 2;
                      Get.toNamed('/convites');
                    },
                    child: Text(
                      "Editar",
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
          ),
        ),
      ),
    );
  }
}
