import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/regulamento_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Regulamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegulamentoController regulamentoController =
        Get.put(RegulamentoController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Regulamento',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return regulamentoController.isLoading.value
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
                          Theme.of(context).textSelectionTheme.selectionColor,
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
                          regulamentoController.controller.value,
                          regulamentoController.onSearchTextChanged,
                          "Pesquise por Nome..."),
                      Expanded(
                        child: regulamentoController.searchResult.isNotEmpty ||
                                regulamentoController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    regulamentoController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        regulamentoController
                                            .searchResult[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        regulamentoController
                                            .searchResult[index].data,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Feather.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        iconSize: 26,
                                        onPressed: () {
                                          regulamentoController.launched =
                                              regulamentoController.launchInBrowser(
                                                  "https://alvocomtec.com.br/acond/downloads/documentos/${regulamentoController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount:
                                    regulamentoController.regulamento.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        regulamentoController
                                            .regulamento[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        regulamentoController
                                            .regulamento[index].data,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Feather.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        iconSize: 26,
                                        onPressed: () {
                                          regulamentoController.launched =
                                              regulamentoController.launchInBrowser(
                                                  "https://alvocomtec.com.br/acond/downloads/documentos/${regulamentoController.regulamento[index].imgdoc}");
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
