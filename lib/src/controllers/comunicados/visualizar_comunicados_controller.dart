import 'dart:convert';
import 'package:condosocio/src/services/comunicados/api_comunicados.dart';
import 'package:condosocio/src/services/comunicados/mapa_comunicados.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarComunicadosController extends GetxController {
  var comunicados = <DadosComunicados>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var fav = false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getComunicados();
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
    comunicados.forEach((details) {
      if (details.titulo.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  void getComunicados() {
    isLoading(true);

    ApiComunicados.getComunicados().then((response) {
      Iterable lista = json.decode(response.body);
      print(lista);
      comunicados.assignAll(
        lista.map((model) => DadosComunicados.fromJson(model)).toList(),
      );
      isLoading(false);
    });
  }

  @override
  void onInit() {
    super.onInit();
    getComunicados();
  }
}
