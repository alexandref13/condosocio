import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/veiculos/veiculos_controller.dart';

void veiculosModalBottomSheet(
    context, String idvei, String marca, String modelo, String placa) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        VeiculosController veiculosController = Get.put(VeiculosController());

        return Container(
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Wrap(
              children: <Widget>[
                // puxador (drag handle)
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 12, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),

                ListTile(
                  leading: SizedBox(
                    width: 70,
                    height: 70,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, top: 10),
                          child: Icon(
                            Icons.directions_car_outlined,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor!,
                            size: 36,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    placa,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                  subtitle: Text(
                    '$marca / $modelo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),

                const Divider(height: 20, color: Colors.blueGrey),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.error,
                        ),
                      ),
                      onPressed: () {
                        veiculosController.idvei.value = idvei;
                        deleteAlert(
                          context,
                          'Deseja excluir veículo?',
                          () {
                            veiculosController.deleteVeiculo().then((value) {
                              if (value == 1) {
                                veiculosController.getVeiculos();
                                showToast(
                                  context,
                                  'Parabéns! Veículo excluído com sucesso.',
                                  '',
                                );
                                Get.back();
                                Get.back();
                              } else {
                                onAlertButtonPressed(
                                  context,
                                  'Algo deu errado\n Tente novamente',
                                  '/home',
                                  'images/error.png',
                                );
                              }
                            });
                          },
                        );
                      },
                      child: const Text(
                        "Excluir",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      });
}
