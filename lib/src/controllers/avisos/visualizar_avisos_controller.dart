import 'dart:convert';
import 'package:condosocio/src/services/avisos/api_avisos.dart';
import 'package:condosocio/src/services/avisos/mapa_avisos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarAvisosController extends GetxController {
  var acessos = <DadosAvisos>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var fav = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getAvisos();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    print('loading');
    refreshController.loadComplete();
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    acessos.forEach((details) {
      if (details.titulo.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getAvisos() {
    isLoading(true);

    ApiAvisos.getAvisos().then((response) {
      Iterable lista = json.decode(response.body);
      print(lista);
      acessos.assignAll(
        lista.map((model) => DadosAvisos.fromJson(model)).toList(),
      );
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAvisos();
  }
}
