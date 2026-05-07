import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FotoOcorrencia extends StatelessWidget {
  const FotoOcorrencia({Key? key}) : super(key: key);

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
            color: Theme.of(context).textSelectionTheme.selectionColor!,
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
                'https://www.condosocio.com.br/acond/downloads/ocorrencias/${ocorrenciasController.imagem.value}',
              ),
              errorBuilder: (context, error, stackTrace) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.broken_image_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Imagem não disponível', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
