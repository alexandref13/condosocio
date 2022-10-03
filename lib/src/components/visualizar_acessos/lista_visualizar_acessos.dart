import 'package:condosocio/src/components/visualizar_acessos/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget listaVisualizarAcessos() {
  VisualizarAcessosController visualizarAcessosController =
      Get.put(VisualizarAcessosController());
  AcessosController acessosController = Get.put(AcessosController());

  return Obx(
    () {
      return SmartRefresher(
        controller: visualizarAcessosController.refreshController,
        onRefresh: visualizarAcessosController.onRefresh,
        onLoading: visualizarAcessosController.onLoading,
        child: visualizarAcessosController.searchResult.isNotEmpty ||
                visualizarAcessosController.search.value.text.isNotEmpty
            ? ListView.builder(
                itemCount: visualizarAcessosController.searchResult.length,
                itemBuilder: (context, index) {
                  var acessos = visualizarAcessosController.searchResult[index];
                  var data = acessos.datahora.split(' ');
                  var newData = data[0];
                  var newHora = data[1];

                  var dataEnt = acessos.dataent.split(' ');
                  var newDataEnt = dataEnt[0];
                  var newHoraEnt = dataEnt[1];

                  var dataSai = acessos.datasai.split(' ');
                  var newDataSai = dataSai[0];
                  var newHoraSai = dataSai[1];

                  return GestureDetector(
                    onTap: () {
                      acessosController.idAce.value = acessos.idace;
                      acessosController.idfav.value = acessos.idfav;
                      acessosController.tel.value = acessos.datasai;
                      acessosController.idvis.value = acessos.idvis;
                      configurandoModalBottomSheet(
                        context,
                        acessos.pessoa,
                        acessos.placa,
                        acessos.tipodoc,
                        acessos.documento,
                        acessos.idfav,
                        acessos.dataent,
                        acessos.cel,
                        acessos.tipopessoa,
                        acessos.idconv,
                        acessos.imgfacial,
                        acessos.idvis,
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2, color: Colors.grey),
                          )),
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Column(
                                  children: [
                                    Text(
                                      '$newData\n$newHora',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    acessos.nomedep != null
                                        ? Container(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Text(
                                              acessos.nomedep,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text(
                                  acessos.pessoa,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                              acessos.dataent == ' '
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        children: [
                                          Text(
                                            '$newDataEnt\n$newHoraEnt',
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
                              acessos.datasai == ' '
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        children: [
                                          Text(
                                            '$newDataSai\n$newHoraSai',
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
                  var acessos = visualizarAcessosController.acessos[index];
                  var data = acessos.datahora.split(' ');
                  var newData = data[0];
                  var newHora = data[1];

                  if (acessos.dataent == '') {
                    acessos.dataent = ' ';
                  }
                  var dataEnt = acessos.dataent.split(' ');
                  var newDataEnt = dataEnt[0];
                  var newHoraEnt = dataEnt[1];

                  if (acessos.datasai == '') {
                    acessos.datasai = ' ';
                  }
                  var dataSai = acessos.datasai.split(' ');
                  var newDataSai = dataSai[0];
                  var newHoraSai = dataSai[1];

                  return GestureDetector(
                    onTap: () {
                      acessosController.idAce.value = acessos.idace;
                      acessosController.idfav.value = acessos.idfav;
                      acessosController.tel.value = acessos.datasai;
                      acessosController.idvis.value = acessos.idvis;

                      configurandoModalBottomSheet(
                          context,
                          acessos.pessoa,
                          acessos.placa,
                          acessos.tipodoc,
                          acessos.documento,
                          acessos.idfav,
                          acessos.dataent,
                          acessos.cel,
                          acessos.tipopessoa,
                          acessos.idconv,
                          acessos.imgfacial,
                          acessos.idvis);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(width: 2, color: Colors.grey),
                          )),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Column(
                                  children: [
                                    Text(
                                      '$newData\n$newHora',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    acessos.nomedep != null
                                        ? Container(
                                            padding: EdgeInsets.only(top: 7),
                                            child: Text(
                                              visualizarAcessosController
                                                  .acessos[index].nomedep,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Text(
                                  visualizarAcessosController
                                      .acessos[index].pessoa,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                              ),
                              visualizarAcessosController
                                          .acessos[index].dataent ==
                                      ' '
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        children: [
                                          Text(
                                            '$newDataEnt\n$newHoraEnt',
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
                              acessos.datasai == ' '
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        children: [
                                          Text(
                                            '$newDataSai\n$newHoraSai',
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
              ),
      );
    },
  );
}
