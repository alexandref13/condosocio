import 'package:condosocio/src/components/dependentes/modal_bottom_sheet.dart';
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
          : dependentesController.dependentes.length == 0
              ? Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'images/semregistro.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                            //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                          ),
                          Text(
                            'Sem registros',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
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
                          Text(
                            'NOME',
                             style: GoogleFonts.montserrat(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          Text(
                            'DESDE',
                            style: GoogleFonts.montserrat(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            'ULT. ACESSO',
                            style: GoogleFonts.montserrat(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            'STATUS',
                            style: GoogleFonts.montserrat(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(''),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: dependentesController
                                    .search.value.text.isNotEmpty ||
                                dependentesController.searchResult.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    dependentesController.searchResult.length,
                                itemBuilder: (_, i) {
                                  var dependentes =
                                      dependentesController.searchResult[i];

                                  return GestureDetector(
                                    onTap: () {
                                      dependentesController.idep.value =
                                          dependentes.idep;
                                      dependentesController.status.value =
                                          dependentes.status;
                                      dependentesModalBottomSheet(
                                        context,
                                        dependentes.nome,
                                        dependentes.sobrenome,
                                        dependentes.status,
                                        dependentes.email,
                                      );
                                    },
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
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                        fontWeight: FontWeight.bold,
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
                                                    fontSize: 12,
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
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                   
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: dependentes.status ==
                                                        'Suspenso'
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
                                itemCount:
                                    dependentesController.dependentes.length,
                                itemBuilder: (_, i) {
                                  var dependentes =
                                      dependentesController.dependentes[i];

                                  return GestureDetector(
                                    onTap: () {
                                      dependentesController.idep.value =
                                          dependentes.idep;
                                      dependentesController.status.value =
                                          dependentes.status;
                                      dependentesModalBottomSheet(
                                        context,
                                        dependentes.nome,
                                        dependentes.sobrenome,
                                        dependentes.status,
                                        dependentes.email,
                                      );
                                    },
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
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                        fontWeight: FontWeight.bold,
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
                                                    fontSize: 12,
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
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: dependentes.status ==
                                                        'Suspenso'
                                                    ? Icon(
                                                        Icons.block_outlined,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      )
                                                    : Icon(
                                                        Icons.done,
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
