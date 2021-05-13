import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/controllers/documentos_controllers/convencao_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Convencao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConvencaoController convencaoController = Get.put(ConvencaoController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Convenção',
        ),
      ),
      body: Obx(
        () {
          return convencaoController.isLoading.value
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
                      boxSearch(context, convencaoController.controller.value,
                          convencaoController.onSearchTextChanged),
                      Expanded(
                        child: convencaoController.searchResult.isNotEmpty ||
                                convencaoController
                                    .controller.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    convencaoController.searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        convencaoController
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
                                        convencaoController
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
                                        iconSize: 30,
                                        onPressed: () {
                                          convencaoController.launched =
                                              convencaoController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${convencaoController.searchResult[index].imgdoc}");
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: convencaoController.convencao.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        convencaoController
                                            .convencao[index].nome,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        convencaoController
                                            .convencao[index].data,
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
                                        iconSize: 30,
                                        onPressed: () {
                                          convencaoController.launched =
                                              convencaoController.launchInBrowser(
                                                  "https://condosocio.com.br/acond/downloads/documentos/${convencaoController.convencao[index].imgdoc}");
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
