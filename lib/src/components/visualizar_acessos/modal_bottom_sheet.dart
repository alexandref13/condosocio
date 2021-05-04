import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/whatsapp_button_pressed.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void configurandoModalBottomSheet(context, String pessoa, String placa,
    String tipoDoc, String documento, idFav, String dataEntrada) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      AcessosController acessosController = Get.put(AcessosController());

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
                dataEntrada == ''
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          deleteAlert(context, 'Deseja excluir este acesso?',
                              () {
                            acessosController.deleteAcesso().then((value) {
                              if (value == 1) {
                                onAlertButtonPressed(
                                  context,
                                  'Acesso excluido',
                                  '/home',
                                );
                              }
                            });
                          });
                        },
                      ),
                // dataEntrada != ''
                //     ? Container()
                //     : IconButton(
                //         icon: Icon(
                //           idFav != null
                //               ? FontAwesome.heart
                //               : FontAwesome.heart_o,
                //           size: 24,
                //         ),
                //         onPressed: () {
                //           acessosController.sendFavorite().then(
                //             (value) {
                //               if (value == 1) {
                //                 onAlertButtonPressed(context,
                //                     'Novo favorito adicionado', '/home');
                //               }
                //               if (value == 0) {
                //                 onAlertButtonPressed(
                //                     context, 'Favorito deletado', '/home');
                //                 acessosController.getFavoritos();
                //                 visualizarAcessosController.getAcessos();
                //               }
                //             },
                //           );
                //         },
                //       ),
                dataEntrada == ''
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          FontAwesome.whatsapp,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          onWhatsappButtonPressed(context, null);
                        },
                      ),
                dataEntrada == ''
                    ? Container()
                    : IconButton(
                        icon: Icon(
                          FontAwesome.telegram,
                          size: 24,
                        ),
                        onPressed: () {
                          onWhatsappButtonPressed(context, null);
                        },
                      ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
