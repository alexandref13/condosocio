import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:condosocio/src/services/ouvidoria/mapa_responda_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespondaController extends GetxController {
  var resposta = <MapaRespondaOuvidoria>[].obs;

  var texto = TextEditingController().obs;
  var isLoading = false.obs;

  sendRespondaOuvidoria() async {
    if (texto.value.text == '') {
      return 'vazio';
    } else {
      isLoading(true);

      final response = await ApiOuvidoria.sendRespondaOuvidoria();

      getResposta();

      var dados = json.decode(response.body);

      isLoading(false);

      return dados;
    }
  }

  getResposta() async {
    isLoading(true);
    var response = await ApiOuvidoria.getRespondaOuvidoria();

    Iterable dados = json.decode(response.body);

    resposta.assignAll(
        dados.map((model) => MapaRespondaOuvidoria.fromJson(model)).toList());
    isLoading(false);
  }

  @override
  void onInit() {
    getResposta();
    super.onInit();
  }
}
