import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos_visualizacao.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos_visualizacao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarAcessosController extends GetxController {
  List<MapaAcessosVisu> acessos;
  var search = TextEditingController().obs;
  var isLoading = true.obs;

  void getAcessos() {
    ApiAcessosVisualizacao.getAcessos().then((response) {
      Iterable lista = json.decode(response.body);
      acessos = lista.map((model) => MapaAcessosVisu.fromJson(model)).toList();
      isLoading(false);
    });
  }
}
