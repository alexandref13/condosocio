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

  return Obx(
    () {
      return visualizarAcessosController.searchResult.isNotEmpty ||
              visualizarAcessosController.search.value.text.isNotEmpty
          ? ListView.builder(
              itemCount: visualizarAcessosController.searchResult.length,
              itemBuilder: (context, index) {
                var search = visualizarAcessosController.searchResult[index];

                var data = search.datahora.split('h');
                var newData = data[0];

                return GestureDetector(
                  onTap: () {
                    configurandoModalBottomSheet(
                      context,
                      search.pessoa,
                      search.placa,
                      search.tipodoc,
                      search.documento,
                      search.idfav,
                      search.dataent,
                    );

                    acessosController.idAce.value =
                        visualizarAcessosController.acessos[index].idace;
                    acessosController.idfav.value =
                        visualizarAcessosController.acessos[index].idfav;
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
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                children: [
                                  Text(
                                    newData,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  search.nome_dep != null
                                      ? Container(
                                          padding: EdgeInsets.only(top: 7),
                                          child: Text(
                                            search.nome_dep,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Text(
                                search.pessoa,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                children: [
                                  Text(
                                    search.dataent,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            search.datasai == ''
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      FontAwesome.clock_o,
                                      size: 24,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Column(
                                      children: [
                                        Text(
                                          search.datasai,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
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
                              child: Icon(Icons.arrow_right),
                            )
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
                var data = visualizarAcessosController.acessos[index].datahora
                    .split('h');
                var newData = data[0];

                return GestureDetector(
                  onTap: () {
                    acessosController.idAce.value =
                        visualizarAcessosController.acessos[index].idace;
                    acessosController.idfav.value =
                        visualizarAcessosController.acessos[index].idfav;
                    acessosController.tel.value =
                        visualizarAcessosController.acessos[index].datasai;
                    configurandoModalBottomSheet(
                        context,
                        visualizarAcessosController.acessos[index].pessoa,
                        visualizarAcessosController.acessos[index].placa,
                        visualizarAcessosController.acessos[index].tipodoc,
                        visualizarAcessosController.acessos[index].documento,
                        visualizarAcessosController.acessos[index].idfav,
                        visualizarAcessosController.acessos[index].dataent);
                  },
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(width: 2, color: Colors.grey),
                        )),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                children: [
                                  Text(
                                    newData,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  visualizarAcessosController
                                              .acessos[index].nome_dep !=
                                          null
                                      ? Container(
                                          padding: EdgeInsets.only(top: 7),
                                          child: Text(
                                            visualizarAcessosController
                                                .acessos[index].nome_dep,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Text(
                                visualizarAcessosController
                                    .acessos[index].pessoa,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Column(
                                children: [
                                  Text(
                                    visualizarAcessosController
                                        .acessos[index].dataent,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            visualizarAcessosController
                                        .acessos[index].datasai ==
                                    ''
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      FontAwesome.clock_o,
                                      size: 24,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Column(
                                      children: [
                                        Text(
                                          visualizarAcessosController
                                              .acessos[index].datasai,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
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
                              child: Icon(Icons.arrow_right),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
    },
  );
}
