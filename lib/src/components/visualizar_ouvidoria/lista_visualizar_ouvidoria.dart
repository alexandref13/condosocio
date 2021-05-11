import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget listaVisualizarOuvidoria() {
  VisualizarOuvidoriaController visualizarOuvidoria = Get.put(
    VisualizarOuvidoriaController(),
  );

  return visualizarOuvidoria.search.value.text.isNotEmpty ||
          visualizarOuvidoria.searchResult.isNotEmpty
      ? ListView.builder(
          itemCount: visualizarOuvidoria.searchResult.length,
          itemBuilder: (context, i) {
            var ouvidoria = visualizarOuvidoria.searchResult[i];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/detalhesOuvidoria');
                visualizarOuvidoria.assunto(ouvidoria.assunto);
                visualizarOuvidoria.message(ouvidoria.msg);
                visualizarOuvidoria.data(ouvidoria.data);
                visualizarOuvidoria.hora(ouvidoria.hora);
                visualizarOuvidoria.status(ouvidoria.status);
                visualizarOuvidoria.id(ouvidoria.id);
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
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
                                  .selectionColor,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: Text(
                            ouvidoria.assunto,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: ouvidoria.status == 0
                              ? Icon(
                                  FontAwesome.clock_o,
                                  size: 24,
                                  color: Theme.of(context).accentColor,
                                )
                              : Icon(
                                  FontAwesome.check,
                                  size: 24,
                                  color: Theme.of(context).accentColor,
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
                Get.toNamed('/detalhesOuvidoria');
                visualizarOuvidoria.assunto(ouvidoria.assunto);
                visualizarOuvidoria.message(ouvidoria.msg);
                visualizarOuvidoria.data(ouvidoria.data);
                visualizarOuvidoria.hora(ouvidoria.hora);
                visualizarOuvidoria.status(ouvidoria.status);
                visualizarOuvidoria.id(ouvidoria.id);
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
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
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
                                  .selectionColor,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: Text(
                            ouvidoria.assunto,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: ouvidoria.status == 0
                              ? Icon(
                                  FontAwesome.clock_o,
                                  size: 24,
                                  color: Theme.of(context).accentColor,
                                )
                              : Icon(
                                  FontAwesome.check,
                                  size: 24,
                                  color: Theme.of(context).accentColor,
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
        );
}
