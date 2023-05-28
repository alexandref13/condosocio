import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:condosocio/src/services/ouvidoria/mapa_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOuvidoriaController extends GetxController {
  var ouvidoria = [].obs;
  var search = TextEditingController().obs;
  var isLoading = false.obs;
  var searchResult = [].obs;

  var data = ''.obs;
  var hora = ''.obs;
  var status = 0.obs;
  var message = ''.obs;
  var assunto = ''.obs;
  var id = ''.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getOuvidoria();
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
    ouvidoria.forEach((details) {
      if (details.assunto.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  Future<void> getOuvidoria() async {
    isLoading(true);
    var response = await ApiOuvidoria.getOuvidoria();

    Iterable lista = json.decode(response.body);

    print(lista);

    ouvidoria.assignAll(
      lista.map((model) => MapaOuvidoria.fromJson(model)).toList(),
    );

    // ouvidoria.value =  lista.map((model) => MapaOuvidoria.fromJson(model)).toList();
    print('Ouvidoria: $ouvidoria');
    isLoading(false);
  }

  @override
  void onInit() {
    getOuvidoria();
    super.onInit();
  }
}
