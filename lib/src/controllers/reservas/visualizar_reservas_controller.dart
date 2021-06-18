import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:condosocio/src/services/reservas/mapa_visualizar_reservas.dart';
import 'package:get/get.dart';

class VisualizarReservasController extends GetxController {
  var reservas = <MapaVisualizarReservas>[].obs;
  var isLoading = false.obs;

  getReservas() async {
    isLoading(true);

    var response = await ApiReservas.getReservas();

    Iterable dados = json.decode(response.body);

    reservas.assignAll(
        dados.map((model) => MapaVisualizarReservas.fromJson(model)).toList());

    isLoading(false);
  }

  @override
  void onInit() {
    getReservas();
    super.onInit();
  }
}
