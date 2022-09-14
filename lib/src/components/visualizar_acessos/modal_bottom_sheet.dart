import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';

void configurandoModalBottomSheet(
  context,
  String pessoa,
  String placa,
  String tipoDoc,
  String documento,
  String idFav,
  String dataEntrada,
  String cel,
  String tipo,
  String idConv,
) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        VisualizarConvitesController visualizarConvitesController =
            Get.put(VisualizarConvitesController());
        LoginController loginController = Get.put(LoginController());
        AcessosController acessosController = Get.put(AcessosController());
        VisualizarAcessosController visualizarAcessosController =
            Get.put(VisualizarAcessosController());

        if (idFav == "0") {
          visualizarAcessosController.fav.value = false;
        } else {
          visualizarAcessosController.fav.value = true;
        }

        return Container(
          padding: EdgeInsets.only(bottom: 8),
          color: Theme.of(context).accentColor,
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: new Icon(
                    Feather.user,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    size: 40,
                  ),
                  title: Text(
                    pessoa,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: cel != ''
                      ? Text(
                          '$tipo | $cel',
                          style: TextStyle(fontSize: 14),
                        )
                      : Text(
                          '$tipo',
                          style: TextStyle(fontSize: 14),
                        ),
                ),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                dataEntrada == ''
                    ? ListTile(
                        leading: new Icon(
                          FontAwesome.whatsapp,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        title: Text('Enviar por WhatsApp'),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        onTap: () {
                          visualizarConvitesController.nameGuest.value = pessoa;
                          visualizarConvitesController.idConv.value = idConv;
                          var celular = cel
                              .replaceAll("+", "")
                              .replaceAll("(", "")
                              .replaceAll(")", "")
                              .replaceAll("-", "")
                              .replaceAll(" ", "");
                          if (celular.length == 13) {
                            visualizarConvitesController
                                .sendWhatsApp()
                                .then((value) {
                              if (value != 0) {
                                /*String message =
                                    'Olá! você foi convidado pelo ${loginController.nome.value} morador do condomínio ${loginController.nomeCondo.value}. Agilize seu acesso clicando no link e preencha os campos em abertos. Grato! https://condosocio.com.br/paginas/acesso_visitante?chave=${value['idace']}';

                                FlutterOpenWhatsapp.sendSingleMessage(
                                  celular,
                                  Uri.encodeFull(message),
                                );*/
                              } else {
                                onAlertButtonPressed(
                                    context,
                                    'Algo deu errado\n Tente novamente',
                                    '/home');
                              }
                            });
                          } else {
                            Get.toNamed('/whatsAppConvite');
                          }
                        },
                      )
                    : Container(),
                dataEntrada != ''
                    ? ListTile(
                        leading: Obx(
                          () => Icon(
                            visualizarAcessosController.fav.value == true
                                ? FontAwesome.heart
                                : FontAwesome.heart_o,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                        title: Obx(
                          () => visualizarAcessosController.fav.value == true
                              ? Text('Remover Favorito')
                              : Text('Adicionar à Favoritos'),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                        onTap: () {
                          visualizarAcessosController.fav.value =
                              !visualizarAcessosController.fav.value;
                          acessosController.sendFavorite().then((value) {
                            visualizarAcessosController.getAcessos();
                            Get.back();
                          });
                        })
                    : Container(),
                dataEntrada == ''
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).errorColor,
                                  )),
                              onPressed: () {
                                deleteAlert(context, 'Deseja deletar o acesso?',
                                    () {
                                  acessosController
                                      .deleteAcesso()
                                      .then((value) {
                                    if (value == 1) {
                                      visualizarAcessosController.getAcessos();
                                      edgeAlertWidget(
                                        context,
                                        'Parabéns!',
                                        'Acesso excluído com sucesso.',
                                      );
                                      Get.back();
                                      Get.back();
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado\n Tente novamente',
                                          '/home');
                                    }
                                  });
                                });
                              },
                              child: Text(
                                "Deletar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            )),
                      )
                    : Container(),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      });
}
