import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FotoOcorrencia extends StatelessWidget {
  const FotoOcorrencia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarOcorrenciasController ocorrenciasController =
        Get.put(VisualizarOcorrenciasController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.close,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .9,
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'FotoOcorrencia',
            child: Image(
              image: NetworkImage(
                'https://alvocomtec.com.br/acond/downloads/ocorrencias/${ocorrenciasController.imagem.value}',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
