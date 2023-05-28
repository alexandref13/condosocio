import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../utils/box_search.dart';

Widget listaVisualizarOuvidoria(BuildContext context) {
  VisualizarOuvidoriaController visualizarOuvidoria = Get.put(
    VisualizarOuvidoriaController(),
  );
  if (visualizarOuvidoria.ouvidoria.length == 0) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                padding: EdgeInsets.only(top: 40),
                //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
              ),
              Text(
                'Ainda não foi feito\nnenhum registro!',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  } else {
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
                    visualizarOuvidoria.id.value = ouvidoria.idouv;
                    Get.toNamed('/detalhesOuvidoria');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    child: ListTile(
                        leading: RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ouvidoria.dia + "  ",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: ouvidoria.mes,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    letterSpacing: 2),
                              ),
                            ],
                          ),
                        ),
                        title: Container(
                          child: Center(
                            child: Text(
                              ouvidoria.assunto,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                          size: 30,
                        )),
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
                    visualizarOuvidoria.id.value = ouvidoria.idouv;
                    Get.toNamed('/detalhesOuvidoria');
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                    child: ListTile(
                        leading: RichText(
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ouvidoria.dia + "  ",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: ouvidoria.mes,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    letterSpacing: 2),
                              ),
                            ],
                          ),
                        ),
                        title: Container(
                          child: Center(
                            child: Text(
                              ouvidoria.assunto,
                              style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                          size: 30,
                        )),
                  ),
                );
              },
            ),
    );
  }
}
