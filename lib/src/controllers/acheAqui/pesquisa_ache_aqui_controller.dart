import 'dart:convert';

import 'package:condosocio/src/services/acheaqui/api_ache_aqui.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui_form.dart';
import 'package:condosocio/src/services/acheaqui/mapa_ache_aqui_pesquisa.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PesquisaAcheAquiController extends GetxController {
  var isLoading = false.obs;

  var pesquisa = TextEditingController().obs;

  var id = ''.obs;
  var wasSearch = false.obs;

  var listaPesquisa = <MapaAcheAquiPesquisa>[].obs;

  var atividades = <MapaAcheAquiForm>[].obs;

  acheAquiPesquisa() async {
    if (pesquisa.value.text == '') {
      return 'vazio';
    } else {
      isLoading(true);

      var response = await ApiAcheAqui.acheAquiPesquisa();

      pesquisa.value.text = '';

      var lista = json.decode(response.body);

      print(lista);

      Iterable dados = json.decode(response.body);

      listaPesquisa.assignAll(
          dados.map((model) => MapaAcheAquiPesquisa.fromJson(model)).toList());

      isLoading(false);
      wasSearch(true);
    }
  }
}
