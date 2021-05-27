import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/components/visualizar_ouvidoria/lista_visualizar_ouvidoria.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarOuvidoria extends StatefulWidget {
  @override
  _VisualizarOuvidoriaState createState() => _VisualizarOuvidoriaState();
}

class _VisualizarOuvidoriaState extends State<VisualizarOuvidoria> {
  VisualizarOuvidoriaController visualizarOuvidoria =
      Get.put(VisualizarOuvidoriaController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return visualizarOuvidoria.isLoading.value
            ? CircularProgressIndicatorWidget()
            : Column(
                children: [
                  boxSearch(
                    context,
                    visualizarOuvidoria.search.value,
                    visualizarOuvidoria.onSearchTextChanged,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'DATA',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'HORA',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ),
                        Text(
                          'TÍTULO',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                  Expanded(child: listaVisualizarOuvidoria())
                ],
              );
      },
    );
  }
}
