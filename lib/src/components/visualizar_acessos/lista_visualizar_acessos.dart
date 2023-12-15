import 'package:condosocio/src/components/visualizar_acessos/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
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
                          "1",
                          "facialacesso");
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
                              acessos.dataent == ' '
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
                                      child: acessos.ctlreg == '0' ||
                                              acessos.ctlreg == '1'
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
                                      acessos.pessoa,
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
                                      acessos.tipopessoa,
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
                                        acessos.ctlfacial == '0' ||
                                                acessos.ctlreg == '0'
                                            //newDataEnt != ""
                                            ? Icon(
                                                Icons.verified_user_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : acessos.ctlfacial == "1"
                                                ? Icon(
                                                    Icons.face_5_sharp,
                                                    size: 24,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  )
                                                : Container(),
                                        SizedBox(width: 5),
                                        acessos.acessotipo == "VEICULO" &&
                                                visualizarAcessosController
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
                                            : acessos.acessotipo ==
                                                        "PEDESTRE" &&
                                                    acessos.ctlfacial == '1' &&
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
                                        visualizarAcessosController
                                                    .acessos[index]
                                                    .tipoacesso ==
                                                'SAIDA'
                                            ? Icon(
                                                Icons.logout_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : Icon(
                                                Icons.login_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(children: [
                                      Text(
                                        '${visualizarAcessosController.acessos[index].tipoacesso} ${visualizarAcessosController.acessos[index].portao}',
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
                                    ])
                                  ],
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
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

                  print(
                      'ACESSO TIPO = ${visualizarAcessosController.acessos[index].acessotipo}');

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
                          "1",
                          "facialacesso");
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
                              visualizarAcessosController
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
                                      child: acessos.ctlreg == '0' ||
                                              acessos.ctlreg == '1'
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
                                      visualizarAcessosController
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
                                      visualizarAcessosController
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
                                        visualizarAcessosController
                                                        .acessos[index]
                                                        .ctlfacial ==
                                                    '0' ||
                                                visualizarAcessosController
                                                        .acessos[index]
                                                        .ctlreg ==
                                                    '0'
                                            //newDataEnt != ""
                                            ? Icon(
                                                Icons.verified_user_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : visualizarAcessosController
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
                                        visualizarAcessosController
                                                        .acessos[index]
                                                        .acessotipo ==
                                                    "VEICULO" &&
                                                visualizarAcessosController
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
                                            : acessos.acessotipo ==
                                                        "PEDESTRE" &&
                                                    acessos.ctlfacial == '1' &&
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
                                        visualizarAcessosController
                                                    .acessos[index]
                                                    .tipoacesso ==
                                                'SAIDA'
                                            ? Icon(
                                                Icons.logout_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                            : Icon(
                                                Icons.login_outlined,
                                                size: 24,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(children: [
                                      Text(
                                        '${visualizarAcessosController.acessos[index].tipoacesso} ${visualizarAcessosController.acessos[index].portao}',
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
                                    ])
                                  ],
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
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
