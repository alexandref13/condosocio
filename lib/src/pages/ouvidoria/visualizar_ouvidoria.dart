import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/components/visualizar_ouvidoria/lista_visualizar_ouvidoria.dart';

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
                  Padding(padding: EdgeInsets.only(top: 20)),
                  boxSearch(
                      context,
                      visualizarOuvidoria.search.value,
                      visualizarOuvidoria.onSearchTextChanged,
                      "Pesquise por Título..."),
                  /*Container(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'DATA',
                            style: GoogleFonts.montserrat(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            'HORA',
                            style: GoogleFonts.montserrat(
                              fontSize: 10.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
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
                                .selectionColor!,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),*/
                  Expanded(child: listaVisualizarOuvidoria(context))
                ],
              );
      },
    );
  }
}
