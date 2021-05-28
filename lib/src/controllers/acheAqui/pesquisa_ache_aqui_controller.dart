import 'dart:convert';

import 'package:condosocio/src/services/acheaqui/api_ache_aqui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PesquisaAcheAquiController extends GetxController {
  var isLoading = false.obs;

  var pesquisa = TextEditingController().obs;

  acheAquiPesquisa() async {
    if (pesquisa.value.text == '') {
      return 'vazio';
    } else {
      isLoading(true);

      var response = await ApiAcheAqui.acheAquiPesquisa();

      var dados = json.decode(response.body);

      print(dados);

      isLoading(false);
    }
  }
}
