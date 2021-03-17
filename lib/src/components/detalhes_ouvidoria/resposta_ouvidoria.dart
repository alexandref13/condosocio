import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class RespostaOuvidoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisualizarOuvidoriaController visualizarOuvidoria =
        Get.put(VisualizarOuvidoriaController());

    LoginController loginController = Get.put(LoginController());
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Theme.of(context).accentColor,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        loginController.nome.value,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      Text(
                        visualizarOuvidoria.hora.value,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    visualizarOuvidoria.message.value,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
