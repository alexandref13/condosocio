import 'dart:convert';

import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcessosController extends GetxController {
  var name = TextEditingController().obs;
  var phone = TextEditingController().obs;
  var isLoading = false.obs;

  var favoritos = [
    'Selecione o favorito',
    'Alexandre Fernandes',
    'Mãe',
  ];
  var favoritosSelecionado = 'Selecione o favorito'.obs;

  var tipos = [
    'Selecione o tipo de visitante',
    'Convidado',
    'Prestador',
    'App Mobilidade',
  ];
  var itemSelecionado = 'Selecione o tipo de visitante'.obs;

  sendAcessos() async {
    final response = await ApiAcessos.sendAcesso();

    var dados = json.decode(response.body);

    if (name.value.text == '' ||
        phone.value.text == '' ||
        itemSelecionado.value == 'Selecione o tipo de visitante') {
      return 'vazio';
    } else {
      if (dados == 0) {
        return 0;
      } else {
        return 1;
      }
    }
  }
}
