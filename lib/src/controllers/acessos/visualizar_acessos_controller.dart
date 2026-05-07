import 'dart:convert';
import 'package:condosocio/src/services/acessos/api_acessos.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarAcessosController extends GetxController {
  var acessos = <MapaAcessos>[].obs;
  var isLoading = true.obs;
  var search = TextEditingController().obs;
  var searchResult = [].obs;
  RxBool fav = false.obs;
  var favoritos = [];

  static const int _pageSize = 30;
  int _page = 0;
  bool _hasMore = true;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await _fetchPage(reset: true);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    if (!_hasMore) {
      refreshController.loadNoData();
      return;
    }
    await _fetchPage(reset: false);
    if (_hasMore) {
      refreshController.loadComplete();
    } else {
      refreshController.loadNoData();
    }
  }

  Future<void> _fetchPage({required bool reset}) async {
    if (reset) {
      _page = 0;
      _hasMore = true;
      isLoading(true);
    }

    try {
      final response = await ApiAcessos.getAcessos(page: _page);
      final Iterable lista = json.decode(response.body);
      final novos = lista.map((m) => MapaAcessos.fromJson(m)).toList();

      if (reset) {
        acessos.assignAll(novos);
      } else {
        acessos.addAll(novos);
      }

      if (novos.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
        if (novos.length < _pageSize) _hasMore = false;
      }
    } catch (e) {
      print('_fetchPage error: $e');
      _hasMore = false;
    } finally {
      isLoading(false);
    }
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) return;
    acessos.forEach((details) {
      if (details.pessoa.toLowerCase().contains(text.toLowerCase()) ||
          details.placa.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }

  Future<dynamic> sendFavorite(bool favValue) async {
    final response = await ApiAcessos.addFav(favValue);
    var dados = json.decode(response.body);
    print("DADOS API; $dados");
    return dados;
  }

  getAcessos() => _fetchPage(reset: true);
}
