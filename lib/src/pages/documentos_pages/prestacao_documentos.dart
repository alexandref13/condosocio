import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/prestacao_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Prestacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PrestacaoController prestacaoController = Get.put(PrestacaoController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prestação',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(
        () {
          return prestacaoController.isLoading.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).textSelectionTheme.selectionColor!,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      boxSearch(
                          context,
                          prestacaoController.controller.value,
                          prestacaoController.onSearchTextChanged,
                          "Pesquise por Nome..."),
                      Expanded(
                        child: prestacaoController.searchResult.isNotEmpty ||
                                prestacaoController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    prestacaoController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      title: Text(
                                        prestacaoController
                                            .searchResult[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      subtitle: Text(
                                        prestacaoController
                                            .searchResult[index].data,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        iconSize: 26,
                                        onPressed: () {
                                          prestacaoController.launched =
                                              prestacaoController.launchInBrowser(
                                                  "https://www.condosocio.com.br/acond/downloads/documentos/${prestacaoController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: prestacaoController.prestacao.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      title: Text(
                                        prestacaoController
                                            .prestacao[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      subtitle: Text(
                                        prestacaoController
                                            .prestacao[index].data,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        iconSize: 26,
                                        onPressed: () {
                                          prestacaoController.launched =
                                              prestacaoController.launchInBrowser(
                                                  "https://www.condosocio.com.br/acond/downloads/documentos/${prestacaoController.prestacao[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
