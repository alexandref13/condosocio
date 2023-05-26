import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/acessos/acessos_controller.dart';

class FacialAcesso extends StatelessWidget {
  const FacialAcesso({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AcessosController acessosController = Get.put(AcessosController());

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
          width: MediaQuery.of(context).size.width * .6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black54.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // define a posição da sombra
              ),
            ],
          ),
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'FotoFacial',
            child: Image(
              image: NetworkImage(
                  'https://alvocomtec.com.br/acond/downloads/${acessosController.tipoimgfacial.value}/${acessosController.imgfacial.value}'),
            ),
          ),
        ),
      ),
    );
  }
}
