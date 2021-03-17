import 'package:condosocio/src/components/visualizar_acessos/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listaVisualizarAcessos() {
  VisualizarAcessosController visualizarAcessosController =
      Get.put(VisualizarAcessosController());
  AcessosController acessosController = Get.put(AcessosController());

  return Obx(() {
    return visualizarAcessosController.searchResult.isNotEmpty ||
            visualizarAcessosController.search.value.text.isNotEmpty
        ? ListView.builder(
            itemCount: visualizarAcessosController.searchResult.length,
            itemBuilder: (context, index) {
              var search = visualizarAcessosController.searchResult[index];
              var data = search.data;
              var cutDate = data.split(" ");
              var day = cutDate[0];

              var cuthour = cutDate[1].split("h<");
              var hour = cuthour[0];

              var dataEnt = search.dataent;
              var cutDataEnt = dataEnt.split('<');
              var dayIn = cutDataEnt[0];

              var cutHoraEnt = cutDataEnt[1].split('>');
              var hourIn = cutHoraEnt[1];

              var dataSai = search.datasai;
              var cutDataSai = dataSai.split('<');
              var dayOut = cutDataSai[0];

              var cutHoraSai = cutDataSai[1].split('>');
              var hourOut = cutHoraSai[1];
              return GestureDetector(
                onTap: () {
                  configurandoModalBottomSheet(
                    context,
                    day,
                    hour,
                    search.pessoa,
                    dayIn,
                    hourIn,
                    dayOut,
                    hourOut,
                    search.placa,
                    search.tipodoc,
                    search.documento,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      )),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  day,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hour,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                              search.pessoa,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  dayIn,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hourIn,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dayOut == ''
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    FontAwesome.clock_o,
                                    size: 40,
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        dayOut,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        hourOut,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: visualizarAcessosController.acessos.length,
            itemBuilder: (context, index) {
              var data = visualizarAcessosController.acessos[index].data;
              var cutDate = data.split(" ");
              var day = cutDate[0];

              var cuthour = cutDate[1].split("h<");
              var hour = cuthour[0];

              var dataEnt = visualizarAcessosController.acessos[index].dataent;
              var cutDataEnt = dataEnt.split('<');
              var dayIn = cutDataEnt[0];

              var cutHoraEnt = cutDataEnt[1].split('>');
              var hourIn = cutHoraEnt[1];

              var dataSai = visualizarAcessosController.acessos[index].datasai;
              var cutDataSai = dataSai.split('<');
              var dayOut = cutDataSai[0];

              var cutHoraSai = cutDataSai[1].split('>');
              var hourOut = cutHoraSai[1];
              return GestureDetector(
                onTap: () {
                  acessosController.idAce.value =
                      visualizarAcessosController.acessos[index].idace;
                  configurandoModalBottomSheet(
                    context,
                    day,
                    hour,
                    visualizarAcessosController.acessos[index].pessoa,
                    dayIn,
                    hourIn,
                    dayOut,
                    hourOut,
                    visualizarAcessosController.acessos[index].placa,
                    visualizarAcessosController.acessos[index].tipodoc,
                    visualizarAcessosController.acessos[index].documento,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      )),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  day,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hour,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Text(
                              visualizarAcessosController.acessos[index].pessoa,
                              style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  dayIn,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hourIn,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dayOut == ''
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    FontAwesome.clock_o,
                                    size: 40,
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        dayOut,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        hourOut,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  });
}
