import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/visualizar_acessos/lista_visualizar_acessos.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarAcessosEntrada extends StatelessWidget {
  const VisualizarAcessosEntrada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(VisualizarAcessosController());

    return Column(
      children: [
        const Padding(padding: EdgeInsets.only(top: 20)),
        boxSearch(
          context,
          ctrl.search.value,
          ctrl.onSearchTextChanged,
          "Pesquise por Nome...",
        ),
        Expanded(child: listaVisualizarAcessos()),
      ],
    );
  }
}
