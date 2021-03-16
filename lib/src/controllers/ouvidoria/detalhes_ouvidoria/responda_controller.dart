import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondaController extends GetxController {
  var controller = TextEditingController().obs;
  var isLoading = false.obs;

  sendRespondaOuvidoria() async {
    final response = await ApiOuvidoria.sendRespondaOuvidoria();

    var dados = json.decode(response.body);
    if (controller.value.text == '') {
      return 'vazio';
    } else {
      if (dados == 1) {
        return 1;
      } else {
        return 0;
      }
    }
  }
}
