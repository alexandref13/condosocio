import 'dart:io';

import 'package:condosocio/src/components/documentos/documentos_categoria_page.dart';
import 'package:condosocio/src/controllers/documentos_controllers/ata_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ata = Get.put(AtaController());

    return DocumentosCategoriaPage(
      titulo: 'Atas',
      isLoading: ata.isLoading,
      searchController: ata.controller.value,
      onSearchTextChanged: ata.onSearchTextChanged,
      itens: () {
        if (ata.searchResult.isNotEmpty ||
            ata.controller.value.text.isNotEmpty) {
          return ata.searchResult.cast();
        }
        return ata.atas;
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
          ata.launched = ata.launchInBrowser(url);
        }
      },
    );
  }
}
