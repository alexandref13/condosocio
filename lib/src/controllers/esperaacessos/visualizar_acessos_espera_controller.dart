import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos_espera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../services/acessos/mapa_acessos_espera.dart';

class VisualizarAcessosEsperaController extends GetxController {
  var acessos = <MapaAcessosEspera>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var fav = false.obs;
  var favoritos = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getAcessosEspera();
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
      if (details.pessoa.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getAcessosEspera() {
    isLoading(true);
    ApiAcessosEspera.getAcessosEspera().then((response) {
      Iterable lista = json.decode(response.body);
      print('Lista ESPERA: $lista');
      acessos.assignAll(
        lista.map((model) => MapaAcessosEspera.fromJson(model)).toList(),
      );
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getAcessosEspera();
  }
}
