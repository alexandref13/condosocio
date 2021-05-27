import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondaController extends GetxController {
  var resposta = [].obs;

  var controller = TextEditingController().obs;
  var isLoading = false.obs;

  sendRespondaOuvidoria() async {
    if (controller.value.text == '') {
      return 'vazio';
    } else {
      final response = await ApiOuvidoria.sendRespondaOuvidoria();

      var dados = json.decode(response.body);

      return dados;
    }
  }

  getResposta() async {
    var response = await ApiOuvidoria.getRespondaOuvidoria();

    var dados = json.decode(response.body);

    print(dados);
  }

  @override
  void onInit() {
    getResposta();
    super.onInit();
  }
}
