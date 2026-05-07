import 'dart:convert';
import 'package:condosocio/src/services/comunicados/api_comunicados.dart';
import 'package:condosocio/src/services/comunicados/mapa_comunicados.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarComunicadosController extends GetxController {
  static const int _pageSize = 20;

  var comunicados = <DadosComunicados>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var search = TextEditingController().obs;
  var searchQuery = ''.obs;
  var searchResult = <DadosComunicados>[].obs;
  var fav = false.obs;
  int _page = 1;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await getComunicados(reset: true);
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

    await getComunicados();
  }

  Future<void> onSearchTextChanged(String text) async {
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
      comunicados.where(
        (details) => details.titulo.toLowerCase().contains(query),
      ),
    );
  }

  Future<void> getComunicados({bool reset = false}) async {
    if (reset) {
      _page = 1;
      hasMore(true);
      refreshController.resetNoData();
    }

    if (isLoadingMore.value || (!hasMore.value && !reset)) {
      return;
    }

    if (_page == 1) {
      isLoading(true);
    } else {
      isLoadingMore(true);
    }

    try {
      final response =
          await ApiComunicados.getComunicados(page: _page, limit: _pageSize);
      final Iterable lista = json.decode(response.body);
      final novosComunicados = lista
          .map((model) => DadosComunicados.fromJson(model))
          .toList(growable: false);

      if (reset || _page == 1) {
        comunicados.assignAll(novosComunicados);
      } else {
        comunicados.addAll(novosComunicados);
      }

      if (searchQuery.value.isNotEmpty) {
        _applySearch();
      }

      hasMore(novosComunicados.length == _pageSize);
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
    getComunicados();
  }

  @override
  void onClose() {
    search.value.dispose();
    super.onClose();
  }
}
