import 'dart:convert';
import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReservasController extends GetxController {
  CalendarioReservasController calendarioController =
      Get.put(CalendarioReservasController());

  var total = 0.obs;

  var titulo = TextEditingController().obs;
  var data = TextEditingController().obs;
  var hora = TextEditingController().obs;

  var isLoading = true.obs;

  agendaReservas() async {
    isLoading(true);

    var response = await ApiReservas.agendaReservas();

    var dados = json.decode(response.body);

    print(dados['dados']);

    if (dados['dados'] != null) {
      for (var eventos in dados['dados']) {
        calendarioController.events
            .putIfAbsent(DateTime.parse(eventos['data_agenda']), () => [])
            .add(
                "${eventos['idevento']} - ${eventos['nome']} | ${eventos['data_agenda']} = ${eventos['titulo']} # ${eventos['areacom']} > ${eventos['status']}");
      }
    }

    isLoading(false);
  }

  @override
  void onInit() {
    agendaReservas();
    super.onInit();
  }
}
