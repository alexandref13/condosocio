import 'dart:convert';
import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:condosocio/src/services/ocorrencias/mapa_respostas_ocorrencias.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RespostaOcorrenciasController extends GetxController {
  VisualizarOcorrenciasController visualizarOcorrenciasController =
      Get.put(VisualizarOcorrenciasController());

  var resposta = <MapaRespostasOcorrencia>[].obs;
  var isLoading = true.obs;
  var texto = TextEditingController().obs;

  var newSize = false.obs;

  getOcorrenciasResposta() async {
    isLoading(true);
    var response = await ApiOcorrencias.getOcorrenciasResp();

    Iterable dados = json.decode(response.body);

    resposta.assignAll(
        dados.map((model) => MapaRespostasOcorrencia.fromJson(model)).toList());

    isLoading(false);
  }

  sendOcorrenciaResp() async {
    if (texto.value.text == '') {
      return 'vazio';
    }
    isLoading(true);

    var response = await ApiOcorrencias.sendOcorrenciasResp();

    texto.value.text = '';

    getOcorrenciasResposta();

    var dados = json.decode(response.body);

    isLoading(false);

    return dados;
  }

  @override
  void onInit() {
    getOcorrenciasResposta();
    super.onInit();
  }
}
