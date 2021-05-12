import 'dart:convert';

import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:condosocio/src/services/ocorrencias/map_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarOcorrenciasController extends GetxController {
  var ocorrencias = [].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    ocorrencias.forEach((details) {
      if (details.titulo.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getOcorrencias() {
    ApiOcorrencias.getOcorrencias().then((response) {
      Iterable lista = json.decode(response.body);
      ocorrencias.value =
          lista.map((model) => MapaOcorrencias.fromJson(model)).toList();
      print(lista);
      isLoading(false);
    });
  }

  @override
  void onInit() {
    getOcorrencias();
    super.onInit();
  }
}
