import 'dart:convert';
import 'package:condosocio/src/services/encomendas/api_encomendas.dart';
import 'package:condosocio/src/services/encomendas/mapa_encomendas.dart';
import 'package:get/get.dart';

class EncomendasController extends GetxController {
  var isLoading = false.obs;

  var encomendas = <MapaEncomendas>[].obs;

  var id = ''.obs;
  var codigo = ''.obs;
  var tipo = ''.obs;
  var info = ''.obs;
  var status = ''.obs;
  var morador = ''.obs;
  var admCriador = ''.obs;
  var dataCriada = ''.obs;
  var admEntrega = ''.obs;
  var idcript = ''.obs;
  var dataEntrega = ''.obs;

  getEncomendas() async {
    isLoading(true);

    var response = await ApiEncomendas.getEncomendas();

    var lista = json.decode(response.body);

    print(lista);

    Iterable dados = json.decode(response.body);

    encomendas.assignAll(
        dados.map((model) => MapaEncomendas.fromJson(model)).toList());

    isLoading(false);
  }

  sendEncomendas() async {
    isLoading(true);

    var response = await ApiEncomendas.sendEncomendas();

    var dados = json.decode(response.body);

    isLoading(false);

    return dados;
  }

  @override
  void onInit() {
    getEncomendas();
    super.onInit();
  }
}
