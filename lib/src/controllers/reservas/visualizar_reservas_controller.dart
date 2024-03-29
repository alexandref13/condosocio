import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:condosocio/src/services/reservas/mapa_visualizar_reservas.dart';
import 'package:get/get.dart';

class VisualizarReservasController extends GetxController {
  var reservas = <MapaVisualizarReservas>[].obs;
  var reservasLength = 0.obs;
  var isLoading = false.obs;

  var now = DateTime.now();
  var data = DateTime.now();
  var dataDetalhes = DateTime.now();

  getReservas() async {
    isLoading(true);

    var response = await ApiReservas.getReservas();

    var dados = json.decode(response.body);

    print('Visualizar Reservas $dados');

    if (dados == 0) {
      reservasLength(0);
    } else if (dados != '0') {
      reservasLength(1);

      Iterable lista = json.decode(response.body);

      reservas.assignAll(lista
          .map((model) => MapaVisualizarReservas.fromJson(model))
          .toList());

      isLoading(false);
    }
  }

  init() {
    dataDetalhes = DateTime(now.year, now.month, now.day + 1);
  }

  @override
  void onInit() {
    getReservas();
    init();
    super.onInit();
  }
}
