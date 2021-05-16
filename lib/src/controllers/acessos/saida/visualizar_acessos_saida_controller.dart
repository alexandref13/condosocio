import 'dart:convert';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/acessos/api_acessos_saida.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos_saida.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarAcessosSaidaController extends GetxController {
  LoginController loginController = Get.put(LoginController());

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

  var tipos = [
    'Selecione o tipo de visitante',
    'Convidado',
    'Prestador',
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
    print(lista);
    acessos.assignAll(
      lista.map((model) => MapaAcessosSaida.fromJson(model)).toList(),
    );

    isLoading(false);
  }

  sendAcessosSaida(String path) async {
    isLoading(true);

    var response = await ApiAcessosSaida.sendAcessosSaida(path);

    getAcessosSaida();

    isLoading(false);

    return response;
  }

  @override
  void onInit() {
    getAcessosSaida();
    super.onInit();
  }
}
