import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/acessos/acessos_controller_espera.dart';
import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';

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
  String imgfacial,
  String idvis,
  String espera,
  String heroTag,
) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        AcessosController acessosController = Get.put(AcessosController());
        AcessosEsperaController acessosEsperaController =
            Get.put(AcessosEsperaController());

        VisualizarAcessosEsperaController visualizarAcessosEsperaController =
            Get.put(VisualizarAcessosEsperaController());

        VisualizarAcessosController visualizarAcessosController =
            Get.put(VisualizarAcessosController());

        if (idFav == "0") {
          visualizarAcessosController.fav.value = false;
        } else {
          visualizarAcessosController.fav.value = true;
        }

        return Container(
          padding: EdgeInsets.only(bottom: 8),
          color: Theme.of(context).colorScheme.secondary,
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: imgfacial == ''
                      ? tipo == "App Mobilidade"
                          ? new Icon(
                              Icons.car_crash_outlined,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              size: 40,
                            )
                          : new Icon(
                              Icons.person,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor!,
                              size: 40,
                            )
                      : GestureDetector(
                          onTap: () {
                            if (imgfacial != '') {
                              Navigator.of(context).pop();
                              Get.toNamed('/facialacesso');
                            }
                          },
                          child: Hero(
                            transitionOnUserGestures: true,
                            tag:
                                heroTag, // Defina um tag exclusivo para cada imagem
                            child: Material(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.circular(5),
                              color: Theme.of(context).primaryColor,
                              elevation: 10,
                              child: Container(
                                width: 40,
                                height: 60,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      tipo == 'Morador'
                                          ? 'https://www.alvocomtec.com.br/acond/downloads/fotosperfil/$imgfacial'
                                          : 'https://www.alvocomtec.com.br/acond/downloads/fotosvisitantes/$imgfacial',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  trailing: imgfacial != ''
                      ? Icon(
                          Icons.arrow_right,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        )
                      : Text(''),
                  title: Text(
                    pessoa,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                  subtitle: Text(
                    tipo,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                  onTap: () {
                    acessosController.imgfacial.value = imgfacial;
                    tipo == 'Morador'
                        ? acessosController.tipoimgfacial.value = "fotosperfil"
                        : acessosController.tipoimgfacial.value =
                            "fotosvisitantes";

                    if (imgfacial != '') {
                      Navigator.of(context).pop();
                      Get.toNamed('/facialacesso');
                    }
                  },
                ),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                dataEntrada != ''
                    ? ListTile(
                        leading: Obx(
                          () => Icon(
                            visualizarAcessosController.fav.value == true
                                ? Icons.favorite // Ícone vazio
                                : Icons.favorite_border, // Ícone preenchido

                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor!,
                          ),
                        ),
                        title: Obx(
                          () => visualizarAcessosController.fav.value == true
                              ? Text(
                                  'Remover Favorito',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                )
                              : Text(
                                  'Adicionar à Favoritos',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                        ),
                        onTap: () {
                          print("Espera: $espera");
                          if (espera == "1") {
                            visualizarAcessosController.fav.value =
                                !visualizarAcessosController.fav.value;
                            acessosController
                                .sendFavorite(espera)
                                .then((value) {
                              visualizarAcessosController.getAcessos();
                              acessosController.getFavoritos();
                            });
                          } else {
                            visualizarAcessosEsperaController.fav.value =
                                !visualizarAcessosEsperaController.fav.value;
                            acessosEsperaController
                                .sendFavorite(espera)
                                .then((value) {
                              visualizarAcessosEsperaController
                                  .getAcessosEspera();
                              acessosEsperaController.getFavoritos();
                            });
                          }
                          Get.back();
                        })
                    : Container(),
                dataEntrada == ' '
                    ? Padding(
                        padding: const EdgeInsets.all(20),
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
                                    Theme.of(context).colorScheme.error,
                                  )),
                              onPressed: () {
                                deleteAlert(context, 'Deseja excluir o acesso?',
                                    () {
                                  if (espera == '1') {
                                    acessosController
                                        .deleteAcesso(espera)
                                        .then((value) {
                                      if (value == 1) {
                                        visualizarAcessosController
                                            .getAcessos();
                                        showToast(
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
                                            '/home',
                                            'images/error.png');
                                      }
                                    });
                                  } else {
                                    acessosEsperaController
                                        .deleteAcesso(espera)
                                        .then((value) {
                                      if (value == 1) {
                                        visualizarAcessosEsperaController
                                            .getAcessosEspera();
                                        showToast(
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
                                            '/home',
                                            'images/error.png');
                                      }
                                    });
                                  }
                                });
                              },
                              child: Text(
                                "Excluir Acesso",
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
