import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';

import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

import '../../controllers/veiculos/veiculos_controller.dart';

void veiculosModalBottomSheet(
    context, String idvei, String marca, String modelo, String placa) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        VeiculosController veiculosController = Get.put(VeiculosController());

        VisualizarConvitesController visualizarConvitesController =
            Get.put(VisualizarConvitesController());

        LoginController loginController = Get.put(LoginController());

        return Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Icon(
                              FontAwesome.car,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      width: 70,
                      height: 70,
                    ),
                    title: Text(
                      placa,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    subtitle: Text(
                      '$marca / $modelo',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                  Divider(
                    height: 20,
                    color: Colors.blueGrey,
                  ),
                  Padding(
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
                            veiculosController.idvei.value = idvei;
                            deleteAlert(
                              context,
                              'Deseja excluir veículo?',
                              () {
                                veiculosController.deleteVeiculo().then(
                                  (value) {
                                    if (value == 1) {
                                      veiculosController.getVeiculos();
                                      edgeAlertWidget(
                                        context,
                                        'Parabéns!',
                                        ' excluído com sucesso.',
                                      );
                                      Get.back();
                                      Get.back();
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Algo deu errado\n Tente novamente',
                                          '/home',
                                          'sim');
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: Text(
                            "Excluir",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        );
      });
}
