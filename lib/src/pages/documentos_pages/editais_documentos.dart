import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/editais_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Editais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditaisController editaisController = Get.put(EditaisController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editais',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return editaisController.isLoading.value
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
                      boxSearch(context, editaisController.controller.value,
                          editaisController.onSearchTextChanged,
                          "Pesquise por Nome..."),
                      Expanded(
                        child: editaisController.searchResult.isNotEmpty ||
                                editaisController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    editaisController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        editaisController
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
                                        editaisController
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
                                          editaisController.launched =
                                              editaisController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${editaisController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: editaisController.editais.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        editaisController.editais[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        editaisController.editais[index].data,
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
                                          editaisController.launched =
                                              editaisController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${editaisController.editais[index].imgdoc}");
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
