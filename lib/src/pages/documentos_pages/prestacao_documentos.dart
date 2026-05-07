import 'dart:io';

import 'package:condosocio/src/components/documentos/documentos_categoria_page.dart';
import 'package:condosocio/src/controllers/documentos_controllers/prestacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Prestacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PrestacaoController());

    return DocumentosCategoriaPage(
      titulo: 'Prestação',
      isLoading: controller.isLoading,
      searchController: controller.controller.value,
      onSearchTextChanged: controller.onSearchTextChanged,
      itens: () {
        if (controller.searchResult.isNotEmpty ||
            controller.controller.value.text.isNotEmpty) {
          return controller.searchResult.cast();
        }
        return controller.prestacao;
      },
      onOpen: (doc) {
        final url =
            'https://www.condosocio.com.br/acond/downloads/documentos/${doc.imgdoc}';
        if (Platform.isAndroid) {
          Get.toNamed('/webview', arguments: {
            'url':
                'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(url)}',
            'titulo': doc.nome,
          });
        } else {
          controller.launched = controller.launchInBrowser(url);
        }
      },
    );
  }
}
