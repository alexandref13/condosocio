import 'package:condosocio/src/components/utils/box_search.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Ouvidoria'),
      ),
      body: Obx(
        () {
          return visualizarOuvidoria.isLoading.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
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
      ),
    );
  }
}
