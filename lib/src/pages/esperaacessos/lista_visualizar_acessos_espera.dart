import 'package:condosocio/src/components/visualizar_acessos/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller_espera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';

Widget listaVisualizarAcessosEspera() {
  VisualizarAcessosEsperaController visualizarAcessosEsperaController =
      Get.put(VisualizarAcessosEsperaController());
  AcessosEsperaController acessosEsperaController =
      Get.put(AcessosEsperaController());

  return Obx(
    () {
      return SmartRefresher(
        controller: visualizarAcessosEsperaController.refreshController,
        onRefresh: visualizarAcessosEsperaController.onRefresh,
        onLoading: visualizarAcessosEsperaController.onLoading,
        child: visualizarAcessosEsperaController.searchResult.isNotEmpty ||
                visualizarAcessosEsperaController.search.value.text.isNotEmpty
            ? ListView.builder(
                itemCount:
                    visualizarAcessosEsperaController.searchResult.length,
                itemBuilder: (context, index) {
                  var acessos =
                      visualizarAcessosEsperaController.searchResult[index];
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
                      acessosEsperaController.idAce.value = acessos.idace;
                      acessosEsperaController.idfav.value = acessos.idfav;
                      acessosEsperaController.tel.value = acessos.datasai;
                      acessosEsperaController.idvis.value = acessos.idvis;
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
                          "0");
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
                                width: MediaQuery.of(context).size.width * 0.1,
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
                                width: MediaQuery.of(context).size.width * 0.1,
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
                                          0.1,
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
                              acessos.ctlreg == "1"
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
                itemCount: visualizarAcessosEsperaController.acessos.length,
                itemBuilder: (context, index) {
                  var acessos =
                      visualizarAcessosEsperaController.acessos[index];
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
                      acessosEsperaController.idAce.value = acessos.idace;
                      acessosEsperaController.idfav.value = acessos.idfav;
                      acessosEsperaController.tel.value = acessos.datasai;
                      acessosEsperaController.idvis.value = acessos.idvis;

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
                          "0");
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
                              visualizarAcessosEsperaController
                                          .acessos[index].dataent ==
                                      ' '
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$newData',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            '$newHora',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              //fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: visualizarAcessosEsperaController
                                                      .acessos[index].ctlreg ==
                                                  '0' ||
                                              visualizarAcessosEsperaController
                                                      .acessos[index].ctlreg ==
                                                  '1'
                                          ? Column(
                                              children: [
                                                Text(
                                                  '$newDataEnt',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '$newHoraEnt',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Text(
                                                  '$newDataSai',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  '$newHoraSai',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Column(
                                  children: [
                                    Text(
                                      visualizarAcessosEsperaController
                                          .acessos[index].pessoa,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      visualizarAcessosEsperaController
                                          .acessos[index].tipopessoa,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        //fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                // width: MediaQuery.of(context).size.width * 0.2,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        (visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlreg ==
                                                        "0" ||
                                                    visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlreg ==
                                                        "2") &&
                                                newDataEnt != ""
                                            ? Icon(
                                                Icons.verified_user_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : visualizarAcessosEsperaController
                                                        .acessos[index]
                                                        .ctlfacial ==
                                                    "1"
                                                ? Icon(
                                                    Icons.face_5_sharp,
                                                    size: 24,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  )
                                                : Container(),
                                        SizedBox(width: 5),
                                        visualizarAcessosEsperaController
                                                        .acessos[index]
                                                        .acessotipo ==
                                                    "VEICULO" &&
                                                visualizarAcessosEsperaController
                                                        .acessos[index]
                                                        .ctlfacial ==
                                                    '1' &&
                                                newDataEnt != ""
                                            ? Icon(
                                                Icons.time_to_leave_sharp,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .acessotipo ==
                                                        "PEDESTRE" &&
                                                    visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlfacial ==
                                                        '1' &&
                                                    newDataEnt != ""
                                                ? Icon(
                                                    Icons.directions_walk,
                                                    size: 24,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  )
                                                : Container(),
                                        SizedBox(width: 5),
                                        (visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlreg ==
                                                        "0" ||
                                                    visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlreg ==
                                                        "1") &&
                                                newDataEnt == ""
                                            ? Icon(
                                                FontAwesome.hourglass_1,
                                                size: 18,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlreg ==
                                                        "2" ||
                                                    visualizarAcessosEsperaController
                                                            .acessos[index]
                                                            .ctlreg ==
                                                        "3"
                                                ? Icon(
                                                    FontAwesome.sign_out,
                                                    size: 24,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  )
                                                : Icon(
                                                    FontAwesome.sign_in,
                                                    size: 24,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(children: [
                                      (visualizarAcessosEsperaController
                                                          .acessos[index]
                                                          .ctlfacial ==
                                                      "0" ||
                                                  visualizarAcessosEsperaController
                                                          .acessos[index]
                                                          .ctlreg ==
                                                      "2") &&
                                              newDataEnt != ""
                                          ? Text(
                                              'PORTARIA',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          : (visualizarAcessosEsperaController
                                                              .acessos[index]
                                                              .ctlfacial ==
                                                          "1" ||
                                                      visualizarAcessosEsperaController
                                                              .acessos[index]
                                                              .ctlreg ==
                                                          "3") &&
                                                  newDataEnt != ""
                                              ? Text(
                                                  '${visualizarAcessosEsperaController.acessos[index].portao}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              : Container(),
                                    ])
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
