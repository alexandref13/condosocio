import 'dart:convert';

import 'package:condosocio/src/services/documentos/api_documentos.dart';
import 'package:condosocio/src/services/documentos/mapa_documentos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PrestacaoController extends GetxController {
  var searchResult = [].obs;
  late List<MapaDocumentos> prestacao;
  var isLoading = true.obs;
  var controller = TextEditingController().obs;

  getDocumentos() {
    ApiDocumentos.getDocumentosPrestacao().then((response) {
      Iterable lista = json.decode(response.body);
      prestacao = lista.map((model) => MapaDocumentos.fromJson(model)).toList();
      isLoading(false);
    });
  }

  @override
  void onInit() {
    getDocumentos();
    super.onInit();
  }

  late Future<void> launched;

  Future<void> launchInBrowser(String url) async {
    final uri = Uri.parse(url);

    if (await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
      return;
    }

    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return;
    }

    throw 'Could not launch $url';
  }

  onSearchTextChanged(String text) {
    searchResult.clear();
    if (text.isEmpty) {
      return;
    }

    prestacao.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }
}
