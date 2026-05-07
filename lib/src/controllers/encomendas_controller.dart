import 'dart:convert';
import 'package:condosocio/src/services/encomendas/api_encomendas.dart';
import 'package:condosocio/src/services/encomendas/mapa_encomendas.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EncomendasController extends GetxController {
  static const int _pageSize = 20;

  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;

  var encomendas = <MapaEncomendas>[].obs;
  int _page = 1;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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
  var imgEncomenda = ''.obs;

  void onRefresh() async {
    await getEncomendas(reset: true);
  }

  void onLoading() async {
    if (!hasMore.value || isLoadingMore.value) {
      if (!hasMore.value) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      return;
    }

    await getEncomendas();
  }

  getEncomendas({bool reset = false}) async {
    if (reset) {
      _page = 1;
      hasMore(true);
      refreshController.resetNoData();
    }

    if (isLoadingMore.value || (!hasMore.value && !reset)) return;

    if (_page == 1) {
      isLoading(true);
    } else {
      isLoadingMore(true);
    }

    try {
      var response = await ApiEncomendas.getEncomendas(
        page: _page,
        limit: _pageSize,
      );

      Iterable dados = json.decode(response.body);
      final novos =
          dados.map((model) => MapaEncomendas.fromJson(model)).toList();

      if (reset || _page == 1) {
        encomendas.assignAll(novos);
      } else {
        encomendas.addAll(novos);
      }

      hasMore(novos.length == _pageSize);
      _page++;

      refreshController.refreshCompleted();
      if (hasMore.value) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } finally {
      isLoading(false);
      isLoadingMore(false);
    }
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
