import 'dart:convert';
import 'package:condosocio/src/services/reservas/api_reservas.dart';
import 'package:condosocio/src/services/reservas/mapa_reservas.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReservasController extends GetxController {
  var areas = <MapaReservas>[].obs;

  var nome = ''.obs;
  var termo = ''.obs;
  var idarea = ''.obs;
  var aprova = ''.obs;
  var multi = ''.obs;
  var tipo = ''.obs;
  var lastTime = 0.obs;

  var isLoading = true.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    getAreas();
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    print('loading');
    refreshController.loadComplete();
  }

  getAreas() async {
    isLoading(true);

    var response = await ApiReservas.getAreas();

    Iterable dados = json.decode(response.body);

    areas.value = dados.map((model) => MapaReservas.fromJson(model)).toList();

    isLoading(false);
  }

  @override
  void onInit() {
    getAreas();
    super.onInit();
  }
}
