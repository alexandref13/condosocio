import 'dart:convert';

import 'package:condosocio/src/controllers/reservas/calendario_reservas_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReservasController extends GetxController {
  ReservasController reservasController = Get.put(ReservasController());
  CalendarioReservasController calendarioReservasController =
      Get.put(CalendarioReservasController());

  var total = 0.obs;

  var titulo = TextEditingController().obs;
  var data = TextEditingController().obs;

  var date = ''.obs;
  var hora = ''.obs;
  var idarea = ''.obs;
  var isChecked = false.obs;
  var isLoading = false.obs;

  incluirReserva() async {
// Obtém a hora atual
    DateTime agora = DateTime.now();
// Obtém a data e hora inseridas convertendo as strings para um objeto DateTime
    DateTime dataHoraInseridas = DateTime.parse('${date.value} ${hora.value}');

    if (titulo.value.text == '' ||
        data.value.text == '' ||
        isChecked.value == false) {
      return 'vazio';
    } else if (dataHoraInseridas.isBefore(agora)) {
      return 'hora invalida';
    } else {
      isLoading(true);

      calendarioReservasController.agendaReservas();

      var response = await ApiReservas.incluirReserva();

      var dados = json.decode(response.body);

      print(dados);

      isLoading(false);

      return dados;
    }
  }

  @override
  void onInit() {
    if (reservasController.termo.value == '') {
      isChecked(true);
    }
    super.onInit();
  }
}
