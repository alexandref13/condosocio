import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget listaVisualizarOuvidoria() {
  VisualizarOuvidoriaController visualizarOuvidoria = Get.put(
    VisualizarOuvidoriaController(),
  );

  return SmartRefresher(
    controller: visualizarOuvidoria.refreshController,
    onRefresh: visualizarOuvidoria.onRefresh,
    onLoading: visualizarOuvidoria.onLoading,
    child: visualizarOuvidoria.search.value.text.isNotEmpty ||
            visualizarOuvidoria.searchResult.isNotEmpty
        ? ListView.builder(
            itemCount: visualizarOuvidoria.searchResult.length,
            itemBuilder: (context, i) {
              var ouvidoria = visualizarOuvidoria.searchResult[i];
              return GestureDetector(
                onTap: () {
                  visualizarOuvidoria.assunto.value = ouvidoria.assunto;
                  visualizarOuvidoria.message.value = ouvidoria.msg;
                  visualizarOuvidoria.data.value = ouvidoria.data;
                  visualizarOuvidoria.hora.value = ouvidoria.hora;
                  visualizarOuvidoria.status.value = ouvidoria.status;
                  visualizarOuvidoria.id.value = ouvidoria.idouv;
                  Get.toNamed('/detalhesOuvidoria');
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
                            child: Text(
                              ouvidoria.data,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              ouvidoria.hora,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.26,
                            child: Text(
                              ouvidoria.assunto,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.05,
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
            itemCount: visualizarOuvidoria.ouvidoria.length,
            itemBuilder: (context, i) {
              var ouvidoria = visualizarOuvidoria.ouvidoria[i];
              return GestureDetector(
                onTap: () {
                  visualizarOuvidoria.assunto.value = ouvidoria.assunto;
                  visualizarOuvidoria.message.value = ouvidoria.msg;
                  visualizarOuvidoria.data.value = ouvidoria.data;
                  visualizarOuvidoria.hora.value = ouvidoria.hora;
                  visualizarOuvidoria.status.value = ouvidoria.status;
                  visualizarOuvidoria.id.value = ouvidoria.idouv;
                  Get.toNamed('/detalhesOuvidoria');
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
                            child: Text(
                              ouvidoria.data,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              ouvidoria.hora,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.26,
                            child: Text(
                              ouvidoria.assunto,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor!,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.05,
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
}
