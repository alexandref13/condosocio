import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/visualizar_ocorrencias/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarOcorrencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisualizarOcorrenciasController ocorrenciasController =
        Get.put(VisualizarOcorrenciasController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Ocorrencias'),
      ),
      body: Obx(
        () {
          return ocorrenciasController.isLoading.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                      ),
                    ),
                  ),
                )
              : ocorrenciasController.ocorrencias.length == 0
                  ? Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black12,
                          child: Image.asset(
                            'images/semregistro.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 100),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sem registros de ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Acessos',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        boxSearch(context, ocorrenciasController.search.value,
                            ocorrenciasController.onSearchTextChanged),
                        Expanded(
                          child: ocorrenciasController.searchResult.length !=
                                      0 ||
                                  ocorrenciasController
                                      .search.value.text.isNotEmpty
                              ? ListView.builder(
                                  itemCount:
                                      ocorrenciasController.searchResult.length,
                                  itemBuilder: (context, index) {
                                    var ocorrencia = ocorrenciasController
                                        .searchResult[index];
                                    return GestureDetector(
                                      onTap: () {
                                        configurandoModalBottomSheet(
                                            context,
                                            ocorrencia.data,
                                            ocorrencia.hora,
                                            ocorrencia.titulo,
                                            ocorrencia.dataoco,
                                            ocorrencia.horaoco,
                                            ocorrencia.status);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.grey),
                                        )),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ocorrencia.data,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    ocorrencia.hora,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                              child: Text(
                                                ocorrencia.titulo,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ocorrencia.dataoco,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    ocorrencia.horaoco,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Icon(
                                                FontAwesome.clock_o,
                                                size: 40,
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              child: Icon(Icons.arrow_right),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  itemCount:
                                      ocorrenciasController.ocorrencias.length,
                                  itemBuilder: (context, index) {
                                    var ocorrencia = ocorrenciasController
                                        .ocorrencias[index];
                                    return GestureDetector(
                                      onTap: () {
                                        configurandoModalBottomSheet(
                                            context,
                                            ocorrencia.data,
                                            ocorrencia.hora,
                                            ocorrencia.titulo,
                                            ocorrencia.dataoco,
                                            ocorrencia.horaoco,
                                            ocorrencia.status);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.grey),
                                        )),
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ocorrencia.data,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    ocorrencia.hora,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.20,
                                              child: Text(
                                                ocorrencia.titulo,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    ocorrencia.dataoco,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    ocorrencia.horaoco,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Icon(
                                                ocorrencia.status == '1'
                                                    ? Feather.check
                                                    : Feather.alert_triangle,
                                                size: 40,
                                                color: ocorrencia.status == '1'
                                                    ? Theme.of(context)
                                                        .accentColor
                                                    : Colors.red,
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              child: Icon(Icons.arrow_right),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}
