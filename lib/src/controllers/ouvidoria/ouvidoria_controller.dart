import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OuvidoriaController extends GetxController {
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
    isLoading(true);
    if (message.value.text == '' || itemSelecionado.value == 'Selecione') {
      return 'vazio';
    } else {
      final response = await ApiOuvidoria.sendOuvidoria();
      var dados = json.decode(response.body);
      itemSelecionado.value = 'Selecione';
      message.value.text = '';
      if (dados == 1) {
        return 1;
      } else {
        return 0;
      }
    }
  }
}
