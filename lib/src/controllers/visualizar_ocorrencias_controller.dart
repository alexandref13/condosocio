import 'dart:convert';

import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:condosocio/src/services/ocorrencias/map_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOcorrenciasController extends GetxController {
  var ocorrencias = [].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getOcorrencias();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    refreshController.loadComplete();
  }

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

  Future<void> getOcorrencias() async {
    isLoading(true);
    var response = await ApiOcorrencias.getOcorrencias();
    Iterable lista = json.decode(response.body);
    ocorrencias.value =
        lista.map((model) => MapaOcorrencias.fromJson(model)).toList();
    isLoading(false);
  }

  @override
  void onInit() {
    getOcorrencias();
    super.onInit();
  }
}
