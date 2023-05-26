import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/outros_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Outros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OutrosController outrosController = Get.put(OutrosController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Outros',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(
        () {
          return outrosController.isLoading.value
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
                          outrosController.controller.value,
                          outrosController.onSearchTextChanged,
                          "Pesquise por Nome..."),
                      Expanded(
                        child: outrosController.searchResult.isNotEmpty ||
                                outrosController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount: outrosController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      title: Text(
                                        outrosController
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
                                        outrosController
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
                                          outrosController.launched =
                                              outrosController.launchInBrowser(
                                                  "https://alvocomtec.com.br/acond/downloads/documentos/${outrosController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: outrosController.outros.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      title: Text(
                                        outrosController.outros[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      subtitle: Text(
                                        outrosController.outros[index].data,
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
                                          outrosController.launched =
                                              outrosController.launchInBrowser(
                                                  "https://alvocomtec.com.br/acond/downloads/documentos/${outrosController.outros[index].imgdoc}");
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
