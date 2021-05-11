import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarDependentes extends StatelessWidget {
  const VisualizarDependentes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return Obx(() {
      return dependentesController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : Column(
              children: [
                boxSearch(
                  context,
                  dependentesController.search.value,
                  dependentesController.onSearchTextChanged,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).accentColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('NOME'),
                      Text('DESDE'),
                      Text('ULT. ACESSOS'),
                      Text('STATUS'),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: dependentesController.search.value.text.isNotEmpty ||
                            dependentesController.searchResult.isNotEmpty
                        ? ListView.builder(
                            itemCount:
                                dependentesController.searchResult.length,
                            itemBuilder: (_, i) {
                              var dependentes =
                                  dependentesController.searchResult[i];

                              return GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.grey),
                                      )),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Text(
                                              '${dependentes.nome} ${dependentes.sobrenome}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                              dependentes.desde,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: Text(
                                              dependentes.ultacesso,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child:
                                                dependentes.status == 'Suspenso'
                                                    ? Icon(
                                                        Icons.block_outlined,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      )
                                                    : Icon(
                                                        FontAwesome.check,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            child: Icon(Icons.arrow_right),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                        : ListView.builder(
                            itemCount: dependentesController.dependentes.length,
                            itemBuilder: (_, i) {
                              var dependentes =
                                  dependentesController.dependentes[i];

                              return GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                            width: 1, color: Colors.grey),
                                      )),
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: Text(
                                              '${dependentes.nome} ${dependentes.sobrenome}',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text(
                                              dependentes.desde,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: Text(
                                              dependentes.ultacesso,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child:
                                                dependentes.status == 'Suspenso'
                                                    ? Icon(
                                                        Icons.block_outlined,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      )
                                                    : Icon(
                                                        FontAwesome.check,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            child: Icon(Icons.arrow_right),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            );
    });
  }
}
