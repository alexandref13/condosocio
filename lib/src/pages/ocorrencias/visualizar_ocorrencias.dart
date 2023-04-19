import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOcorrencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisualizarOcorrenciasController ocorrenciasController =
        Get.put(VisualizarOcorrenciasController());

    return Obx(
      () {
        return ocorrenciasController.isLoading.value
            ? CircularProgressIndicatorWidget()
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
                            Text(
                              'SEM REGISTRO',
                              style: GoogleFonts.montserrat(
                                fontSize: 16.0,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 20)),
                      boxSearch(
                          context,
                          ocorrenciasController.search.value,
                          ocorrenciasController.onSearchTextChanged,
                          "Pesquise por Título..."),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Theme.of(context).accentColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'CRIADO',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              'TÍTULO',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'DATA',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              child: Text(
                                'STATUS',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(''),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: SmartRefresher(
                        controller: ocorrenciasController.refreshController,
                        onRefresh: ocorrenciasController.onRefresh,
                        onLoading: ocorrenciasController.onLoading,
                        child: ocorrenciasController.searchResult.length != 0 ||
                                ocorrenciasController
                                    .search.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    ocorrenciasController.searchResult.length,
                                itemBuilder: (context, index) {
                                  var ocorrencia =
                                      ocorrenciasController.searchResult[index];
                                  return GestureDetector(
                                    onTap: () {
                                      ocorrenciasController.idoco.value =
                                          ocorrencia.id;
                                      ocorrenciasController.data.value =
                                          ocorrencia.data;
                                      ocorrenciasController.tipo.value =
                                          ocorrencia.tipoco;
                                      ocorrenciasController.hour.value =
                                          ocorrencia.hora;
                                      ocorrenciasController.dataoco.value =
                                          ocorrencia.dataoco;
                                      ocorrenciasController.houroco.value =
                                          ocorrencia.horaoco;
                                      ocorrenciasController.titulo.value =
                                          ocorrencia.titulo;
                                      ocorrenciasController.status.value =
                                          ocorrencia.status;
                                      ocorrenciasController.descricao.value =
                                          ocorrencia.desc;
                                      ocorrenciasController.imagem.value =
                                          ocorrencia.imgoco;

                                      Get.toNamed('/respostaOcorrencia');
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${ocorrencia.data} ${ocorrencia.hora}",
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Text(
                                              ocorrencia.titulo,
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${ocorrencia.dataoco} ${ocorrencia.horaoco}",
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: Icon(
                                              ocorrencia.status == '1'
                                                  ? Icons.done
                                                  : Icons.schedule_outlined,
                                              size: 24,
                                              color: ocorrencia.status == '1'
                                                  ? Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor
                                                  : Colors.yellow,
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
                                  var ocorrencia =
                                      ocorrenciasController.ocorrencias[index];
                                  return GestureDetector(
                                    onTap: () {
                                      ocorrenciasController.idoco.value =
                                          ocorrencia.id;
                                      ocorrenciasController.data.value =
                                          ocorrencia.data;
                                      ocorrenciasController.tipo.value =
                                          ocorrencia.tipoco;
                                      ocorrenciasController.hour.value =
                                          ocorrencia.hora;
                                      ocorrenciasController.dataoco.value =
                                          ocorrencia.dataoco;
                                      ocorrenciasController.houroco.value =
                                          ocorrencia.horaoco;
                                      ocorrenciasController.titulo.value =
                                          ocorrencia.titulo;
                                      ocorrenciasController.status.value =
                                          ocorrencia.status;
                                      ocorrenciasController.descricao.value =
                                          ocorrencia.desc;
                                      ocorrenciasController.imagem.value =
                                          ocorrencia.imgoco;

                                      Get.toNamed('/respostaOcorrencia');
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${ocorrencia.data} ${ocorrencia.hora}",
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Text(
                                              ocorrencia.titulo,
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
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${ocorrencia.dataoco} ${ocorrencia.horaoco}",
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            child: Icon(
                                              ocorrencia.status == '1'
                                                  ? Icons.done
                                                  : Icons.schedule_outlined,
                                              size: 24,
                                              color: ocorrencia.status == '1'
                                                  ? Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor
                                                  : Colors.yellow,
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
                      )),
                    ],
                  );
      },
    );
  }
}
