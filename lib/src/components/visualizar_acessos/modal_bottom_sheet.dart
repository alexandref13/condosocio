import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/components/whatsapp_button_pressed.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void configurandoModalBottomSheet(context, String pessoa, String placa,
    String tipoDoc, String documento, idFav) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      AcessosController acessosController = Get.put(AcessosController());
      VisualizarAcessosController visualizarAcessosController =
          Get.put(VisualizarAcessosController());

      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: EdgeInsets.all(8),
        color: Theme.of(context).accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                "Você pode deletar o registro, incluir o visitante em seus favoritos ou mandar um convite por meio do Whatsapp ou Telegram para $pessoa.",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTheme(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      acessosController.deleteAcesso().then((value) {
                        if (value == 1) {
                          onAlertButtonPressed(
                            context,
                            'Acesso excluido',
                            '/home',
                          );
                        }
                      });
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFFD11A2A);
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      Icons.delete,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      acessosController.sendFavorite().then(
                        (value) {
                          if (value == 1) {
                            onAlertButtonPressed(
                                context, 'Novo favorito adicionado', '/home');
                          }
                          if (value == 0) {
                            onAlertButtonPressed(
                                context, 'Favorito deletado', '/home');
                            acessosController.getFavoritos();
                            visualizarAcessosController.getAcessos();
                          }
                        },
                      );
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context)
                              .textSelectionTheme
                              .selectionColor;
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      idFav != null ? FontAwesome.heart : FontAwesome.heart_o,
                      size: 24,
                      color: Color(0xff8a0000),
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {
                      onWhatsappButtonPressed(context, null);
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFF075e54);
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      FontAwesome.whatsapp,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.white;
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      FontAwesome.telegram,
                      size: 24,
                      color: Color(0xFF0088CC),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
