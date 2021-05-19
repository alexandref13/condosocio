import 'dart:convert';

import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReservasController extends GetxController {
  var titulo = TextEditingController().obs;
  var data = TextEditingController().obs;
  var hora = TextEditingController().obs;

  var isLoading = true.obs;

  areasReservas() async {
    isLoading(true);

    var response = await ApiReservas.agendaReservas();

    var dados = json.decode(response.body);

    print(dados);

    isLoading(false);
  }

  @override
  void onInit() {
    areasReservas();
    super.onInit();
  }
}
