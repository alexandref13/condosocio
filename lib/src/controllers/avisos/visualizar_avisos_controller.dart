import 'dart:convert';
import 'package:condosocio/src/services/avisos/api_avisos.dart';
import 'package:condosocio/src/services/avisos/mapa_avisos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarAvisosController extends GetxController {
  static const int _pageSize = 20;

  var avisos = <DadosAvisos>[].obs;
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var hasMore = true.obs;
  var search = TextEditingController().obs;
  var searchQuery = ''.obs;
  var searchResult = <DadosAvisos>[].obs;
  int _page = 1;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await getAvisos(reset: true);
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
    await getAvisos();
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
      avisos.where(
        (aviso) => aviso.titulo.toLowerCase().contains(query),
      ),
    );
  }

  Future<void> getAvisos({bool reset = false}) async {
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
      final response = await ApiAvisos.getAvisos(page: _page, limit: _pageSize);
      final Iterable lista = json.decode(response.body);
      final novosAvisos = lista
          .map((model) => DadosAvisos.fromJson(model))
          .toList(growable: false);

      if (reset || _page == 1) {
        avisos.assignAll(novosAvisos);
      } else {
        avisos.addAll(novosAvisos);
      }

      if (searchQuery.value.isNotEmpty) {
        _applySearch();
      }

      hasMore(novosAvisos.length == _pageSize);
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
    getAvisos();
  }

  @override
  void onClose() {
    search.value.dispose();
    super.onClose();
  }
}
