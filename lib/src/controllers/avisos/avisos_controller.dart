import 'dart:convert';
import 'package:condosocio/src/services/avisos/api_avisos.dart';
import 'package:condosocio/src/services/avisos/mapa_avisos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AvisosController extends GetxController {
  List<DadosAvisos> avisos;
  var titulo = ''.obs;
  var texto = ''.obs;
  var dia = ''.obs;
  var mes = ''.obs;
  var hora = ''.obs;
  var isLoading = true.obs;

  void getAvisos() {
    ApiAvisos.getAvisos().then((response) {
      Iterable lista = json.decode(response.body);
      avisos = lista.map((model) => DadosAvisos.fromJson(model)).toList();
      isLoading(false);
    });
  }
}
