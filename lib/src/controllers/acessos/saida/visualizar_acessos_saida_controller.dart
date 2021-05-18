import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos_saida.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos_saida.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarAcessosSaidaController extends GetxController {
  var nameController = TextEditingController().obs;
  var obs = TextEditingController().obs;

  var acessos = [].obs;
  var isLoading = false.obs;

  var search = TextEditingController().obs;
  var searchResult = [].obs;

  var image = ''.obs;
  var name = ''.obs;
  var createDate = ''.obs;
  var outDate = ''.obs;
  var tipo = ''.obs;
  var id = ''.obs;

  var tipos = [
    'Selecione o tipo de visitante',
    'Funcionário',
    'Prestador de Serviço',
  ];
  var itemSelecionado = 'Selecione o tipo de visitante'.obs;

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }
    acessos.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  getAcessosSaida() async {
    isLoading(true);
    var response = await ApiAcessosSaida.getAcessosSaida();

    var lista = json.decode(response.body);
    acessos.assignAll(
      lista.map((model) => MapaAcessosSaida.fromJson(model)).toList(),
    );

    isLoading(false);
  }

  sendAcessosSaida(String path) async {
    if (nameController.value.text == '' ||
        obs.value.text == '' ||
        itemSelecionado.value == 'Selecione o tipo de visitante') {
      return 'vazio';
    } else {
      isLoading(true);

      var response = await ApiAcessosSaida.sendAcessosSaida(path);

      getAcessosSaida();

      isLoading(false);

      return response;
    }
  }

  editarFoto(String path) async {
    isLoading(true);

    var response = await ApiAcessosSaida.editarFoto(path);

    getAcessosSaida();

    return response;
  }

  deleteAcessosSaida() async {
    isLoading(true);

    var response = await ApiAcessosSaida.deleteAcessosSaida();

    var dados = json.decode(response.body);

    getAcessosSaida();

    return dados;
  }

  @override
  void onInit() {
    getAcessosSaida();
    super.onInit();
  }
}
