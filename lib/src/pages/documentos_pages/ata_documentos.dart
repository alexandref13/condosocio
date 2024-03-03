import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/ata_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Ata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AtaController ata = Get.put(AtaController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Atas',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(
        () {
          return ata.isLoading.value
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
                      boxSearch(context, ata.controller.value,
                          ata.onSearchTextChanged, "Pesquise por Nome..."),
                      Expanded(
                        child: ata.searchResult.isNotEmpty ||
                                ata.controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount: ata.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      title: Text(
                                        ata.searchResult[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      subtitle: Text(
                                        ata.searchResult[index].data,
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
                                          ata.launched = ata.launchInBrowser(
                                              "https://www.condosocio.com.br/acond/downloads/documentos/${ata.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: ata.atas.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    child: ListTile(
                                      title: Text(
                                        ata.atas[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                      subtitle: Text(
                                        ata.atas[index].data,
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
                                          ata.launched = ata.launchInBrowser(
                                              "https://www.condosocio.com.br/acond/downloads/documentos/${ata.atas[index].imgdoc}");
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
