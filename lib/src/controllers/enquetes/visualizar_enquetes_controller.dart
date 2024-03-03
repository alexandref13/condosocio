import 'dart:convert';
import 'package:condosocio/src/services/enquetes/api_enquetes.dart';
import 'package:condosocio/src/services/enquetes/mapa_enquetes.dart';
import 'package:get/get.dart';

class VisualizarEnquetesController extends GetxController {
  List<MapaEnquetes> enquetes = [];

  var month = ''.obs;
  var idenq = ''.obs;
  var titulo = ''.obs;

  var isLoading = true.obs;

  getEnquetes() async {
    isLoading(true);
    var response = await ApiEnquetes.getEnquetes();

    Iterable dados = json.decode(response.body);

    print('Enquetes Dados: $dados');

    enquetes = dados.map((model) => MapaEnquetes.fromJson(model)).toList();
    print('Enquetes: $enquetes');
    isLoading(false);
  }

  @override
  void onInit() {
    getEnquetes();
    super.onInit();
  }
}
