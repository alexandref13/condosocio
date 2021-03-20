import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarAcessosController extends GetxController {
  var acessos = [].obs;
  var search = TextEditingController().obs;
  var isLoading = true.obs;
  var searchResult = [].obs;

  var idfav = ''.obs;
  var idace = ''.obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    acessos.forEach((details) {
      if (details.pessoa.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getAcessos() {
    ApiAcessos.getAcessos().then((response) {
      Iterable lista = json.decode(response.body);
      acessos.assignAll(
          lista.map((model) => MapaAcessos.fromJson(model)).toList());
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAcessos();
  }
}
