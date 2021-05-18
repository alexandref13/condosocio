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
                  boxSearch(
                    context,
                    visualizarOuvidoria.search.value,
                    visualizarOuvidoria.onSearchTextChanged,
                  ),
                  Expanded(child: listaVisualizarOuvidoria())
                ],
              );
      },
    );
  }
}
