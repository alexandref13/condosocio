import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FotoFacial extends StatelessWidget {
  const FotoFacial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());

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
            tag: 'fotoFacial',
            child: Image(
              image: NetworkImage(
                  'https://alvocomtec.com.br/acond/downloads/fotosperfil/${loginController.imgfacial.value}'),
            ),
          ),
        ),
      ),
    );
  }
}
