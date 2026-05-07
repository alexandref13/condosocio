import 'dart:convert';

import 'package:condosocio/src/services/documentos/api_documentos.dart';
import 'package:condosocio/src/services/documentos/mapa_documentos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContratosController extends GetxController {
  List<MapaDocumentos> contratos = [];
  var searchResult = [].obs;
  var isLoading = true.obs;
  var controller = TextEditingController().obs;

  getDocumentos() {
    ApiDocumentos.getDocumentosContratos().then((response) {
      Iterable lista = json.decode(response.body);
      contratos = lista.map((model) => MapaDocumentos.fromJson(model)).toList();
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

    contratos.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()))
        searchResult.add(details);
    });
  }
}
