import 'dart:convert';

import 'package:condosocio/src/services/ouvidoria/api_ouvidoria.dart';
import 'package:condosocio/src/services/ouvidoria/mapa_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarOuvidoriaController extends GetxController {
  List<MapaOuvidoria> ouvidoria = [];
  var search = TextEditingController().obs;
  var isLoading = true.obs;
  var searchResult = [].obs;

  var data = ''.obs;
  var hora = ''.obs;
  var status = 0.obs;
  var message = ''.obs;
  var assunto = ''.obs;
  var id = ''.obs;

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

  void getOuvidoria() {
    ApiOuvidoria.getOuvidoria().then((response) {
      Iterable lista = json.decode(response.body);
      ouvidoria = lista.map((model) => MapaOuvidoria.fromJson(model)).toList();
      isLoading(false);
    });
  }

  @override
  void onInit() {
    getOuvidoria();
    super.onInit();
  }
}
