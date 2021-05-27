import 'dart:convert';

import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OuvidoriaController extends GetxController {
  VisualizarOuvidoriaController visualizarOuvidoriaController =
      Get.put(VisualizarOuvidoriaController());

  var message = TextEditingController().obs;
  var isLoading = false.obs;
  var assuntos = [
    'Selecione',
    'Reclamação',
    'Solicitação',
    'Sugestão',
    'Elogio',
    'Boleto 2ª via',
    'Acordo para pagamento',
    'Alteração de titularidade',
    'Alteração de usuário',
    'Outro'
  ];
  var itemSelecionado = 'Selecione'.obs;

  sendOuvidoria() async {
    if (message.value.text == '' || itemSelecionado.value == 'Selecione') {
      return 'vazio';
    } else {
      isLoading(true);

      final response = await ApiOuvidoria.sendOuvidoria();

      visualizarOuvidoriaController.getOuvidoria();

      var dados = json.decode(response.body);

      itemSelecionado.value = 'Selecione';

      message.value.text = '';

      isLoading(false);

      return dados;
    }
  }
}
