import 'dart:convert';
import 'package:condosocio/src/services/comunicados/api_comunicados.dart';
import 'package:condosocio/src/services/comunicados/mapa_comunicados.dart';
import 'package:get/get.dart';

class ComunicadosController extends GetxController {
  late List<DadosComunicados> comunicados;
  var titulo = ''.obs;
  var arquivo = ''.obs;
  var dia = ''.obs;
  var mes = ''.obs;
  var isLoading = true.obs;

  void getComunicados() {
    ApiComunicados.getComunicados().then((response) {
      Iterable lista = json.decode(response.body);
      comunicados =
          lista.map((model) => DadosComunicados.fromJson(model)).toList();
      isLoading(false);
    });
  }
}
