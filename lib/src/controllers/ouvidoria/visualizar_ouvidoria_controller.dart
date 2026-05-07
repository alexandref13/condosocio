import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:condosocio/src/services/ouvidoria/mapa_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOuvidoriaController extends GetxController {
  var ouvidoria = <MapaOuvidoria>[].obs;
  var search = TextEditingController().obs;
  var searchQuery = ''.obs;
  var isLoading = false.obs;
  var searchResult = <MapaOuvidoria>[].obs;

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
    refreshController.loadComplete();
  }

  onSearchTextChanged(String text) {
    searchQuery(text.trim());
    if (searchQuery.value.isEmpty) {
      searchResult.clear();
      return;
    }
    _applySearch();
  }

  void _applySearch() {
    final query = searchQuery.value.toLowerCase();
    searchResult.assignAll(
      ouvidoria.where(
        (details) => details.assunto.toLowerCase().contains(query),
      ),
    );
  }

  Future<void> getOuvidoria() async {
    isLoading(true);
    var response = await ApiOuvidoria.getOuvidoria();

    Iterable lista = json.decode(response.body);

    ouvidoria.assignAll(
      lista.map((model) => MapaOuvidoria.fromJson(model)).toList(),
    );

    if (searchQuery.value.isNotEmpty) {
      _applySearch();
    }
    isLoading(false);
  }

  @override
  void onInit() {
    getOuvidoria();
    super.onInit();
  }

  @override
  void onClose() {
    search.value.dispose();
    super.onClose();
  }
}
