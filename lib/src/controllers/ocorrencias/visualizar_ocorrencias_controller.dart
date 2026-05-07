import 'dart:convert';

import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:condosocio/src/services/ocorrencias/map_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOcorrenciasController extends GetxController {
  static const int _pageSize = 20;

  var idoco = ''.obs;
  var data = ''.obs;
  var hour = ''.obs;
  var dataoco = ''.obs;
  var houroco = ''.obs;
  var titulo = ''.obs;
  var status = ''.obs;
  var descricao = ''.obs;
  var imagem = ''.obs;
  var tipo = ''.obs;

  var ocorrencias = <MapaOcorrencias>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var search = TextEditingController().obs;
  var searchQuery = ''.obs;
  var searchResult = <MapaOcorrencias>[].obs;
  int _page = 1;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await getOcorrencias(reset: true);
  }

  void onLoading() async {
    if (searchQuery.value.isNotEmpty || !hasMore.value || isLoadingMore.value) {
      if (!hasMore.value) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
      return;
    }
    await getOcorrencias();
  }

  void onSearchTextChanged(String text) {
    searchQuery(text.trim());
    if (searchQuery.value.isEmpty) {
      searchResult.clear();
      refreshController.resetNoData();
      return;
    }
    _applySearch();
  }

  void _applySearch() {
    final query = searchQuery.value.toLowerCase();
    searchResult.assignAll(
      ocorrencias.where(
        (o) => o.titulo.toLowerCase().contains(query),
      ),
    );
  }

  Future<void> getOcorrencias({bool reset = false}) async {
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
      final response = await ApiOcorrencias.getOcorrencias(
        page: _page,
        limit: _pageSize,
      );
      final Iterable lista = json.decode(response.body);
      final novos = lista
          .map((model) => MapaOcorrencias.fromJson(model))
          .toList(growable: false);

      if (reset || _page == 1) {
        ocorrencias.assignAll(novos);
      } else {
        ocorrencias.addAll(novos);
      }

      if (searchQuery.value.isNotEmpty) {
        _applySearch();
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

  @override
  void onInit() {
    super.onInit();
    getOcorrencias();
  }

  @override
  void onClose() {
    search.value.dispose();
    super.onClose();
  }
}
