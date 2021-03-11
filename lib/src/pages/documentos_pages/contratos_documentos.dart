import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/contratos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Contratos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContratosController contratosController = Get.put(ContratosController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contratos',
        ),
      ),
      body: Obx(
        () {
          return contratosController.isLoading.value
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
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      boxSearch(context, contratosController.controller.value,
                          contratosController.onSearchTextChanged),
                      Expanded(
                        child: contratosController.searchResult.isNotEmpty ||
                                contratosController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    contratosController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        contratosController
                                            .searchResult[index].nome,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        contratosController
                                            .searchResult[index].data,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
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
                                        iconSize: 30,
                                        onPressed: () {
                                          contratosController.launched =
                                              contratosController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${contratosController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: contratosController.contratos.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        contratosController
                                            .contratos[index].nome,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        contratosController
                                            .contratos[index].data,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
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
                                        iconSize: 30,
                                        onPressed: () {
                                          contratosController.launched =
                                              contratosController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${contratosController.contratos[index].imgdoc}");
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
