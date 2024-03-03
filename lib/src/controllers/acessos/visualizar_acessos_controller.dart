import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarAcessosController extends GetxController {
  var acessos = <MapaAcessos>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  var fav = false.obs;
  var favoritos = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getAcessos();
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

  getAcessos() {
    isLoading(true);
    ApiAcessos.getAcessos().then((response) {
      Iterable lista = json.decode(response.body);
      print(lista);
      acessos.assignAll(
        lista.map((model) => MapaAcessos.fromJson(model)).toList(),
      );
      isLoading(false);
    });
  }

  /*@override
  void onInit() {
    super.onInit();
    getAcessos();
  }*/
}
