import 'dart:convert';

import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:condosocio/src/services/ocorrencias/mapa_respostas_ocorrencias.dart';
import 'package:get/get.dart';

class RespostaOcorrenciasController extends GetxController {
  var resposta = <MapaRespostasOcorrencia>[];
  var isLoading = true.obs;

  getOcorrenciasResposta() async {
    isLoading(true);
    var response = await ApiOcorrencias.getOcorrenciasResp();
    var lista = json.decode(response.body);

    print(lista);

    Iterable dados = json.decode(response.body);

    resposta =
        dados.map((model) => MapaRespostasOcorrencia.fromJson(model)).toList();
    isLoading(false);
  }

  @override
  void onInit() {
    getOcorrenciasResposta();
    super.onInit();
  }
}
