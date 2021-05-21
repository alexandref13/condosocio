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

  var isChecked = false.obs;

  var isLoading = false.obs;

  incluirReserva() async {
    if (titulo.value.text == '' ||
        data.value.text == '' ||
        isChecked.value == false) {
      return 'vazio';
    } else {
      isLoading(true);

      calendarioReservasController.agendaReservas();

      var response = await ApiReservas.incluirReserva();

      var dados = json.decode(response.body);

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
