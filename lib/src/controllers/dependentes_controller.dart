import 'dart:convert';
import 'package:condosocio/src/services/dependentes/api_dependentes.dart';
import 'package:condosocio/src/services/dependentes/mapa_dependentes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DependentesController extends GetxController {
  var isLoading = false.obs;

  var nome = TextEditingController().obs;
  var sobrenome = TextEditingController().obs;
  var email = TextEditingController().obs;
  var genero = TextEditingController().obs;

  var dependentes = [].obs;

  var search = TextEditingController().obs;
  var searchResult = [].obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    dependentes.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()) ||
          details.sobrenome.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  sendDependentes() async {
    isLoading(true);

    var response = await ApiDependentes.sendDependentes();

    var dados = json.decode(response.body);

    isLoading(false);

    return dados;
  }

  getDependentes() async {
    isLoading(true);

    var response = await ApiDependentes.getDependentes();

    var dados = json.decode(response.body);

    dependentes.value =
        dados.map((model) => DependentesMapa.fromJson(model)).toList();

    isLoading(false);

    return dados;
  }

  @override
  void onInit() {
    getDependentes();
    super.onInit();
  }
}
