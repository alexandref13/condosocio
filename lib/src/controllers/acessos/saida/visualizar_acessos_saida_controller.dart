import 'dart:convert';
import 'dart:io';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/acessos/api_acessos_saida.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos_saida.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class VisualizarAcessosSaidaController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var acessos = [].obs;
  var isLoading = true.obs;

  var search = TextEditingController().obs;
  var searchResult = [].obs;

  var image = ''.obs;
  var name = ''.obs;
  var createDate = ''.obs;
  var outDate = ''.obs;

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

  @override
  void onInit() {
    getAcessosSaida();
    super.onInit();
  }
}
