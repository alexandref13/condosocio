import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarConviteWidget extends StatelessWidget {
  const VisualizarConviteWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ConvitesController convitesController = Get.put(ConvitesController());
    VisualizarConvitesController visualizarConviteController =
        Get.put(VisualizarConvitesController());

    return Obx(() {
      return visualizarConviteController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : convitesController.convites.length == 0
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
              : Container(
                  child: Column(
                    children: [
                      boxSearch(context, convitesController.search.value,
                          convitesController.onSearchTextChanged),
                      Expanded(
                          child: SmartRefresher(
                        controller: convitesController.refreshController,
                        onRefresh: convitesController.onRefresh,
                        onLoading: convitesController.onLoading,
                        child: convitesController.searchResult.length != 0 ||
                                convitesController.search.value.text.isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    convitesController.searchResult.length,
                                itemBuilder: (_, i) {
                                  var convites =
                                      convitesController.searchResult[i];

                                  var date = DateTime.now();
                                  var endDate =
                                      DateTime.parse(convites.datafinal);

                                  var before = date.isBefore(endDate);

                                  return Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: GestureDetector(
                                        onTap: () {
                                          visualizarConviteController
                                              .titulo.value = convites.titulo;
                                          visualizarConviteController
                                              .qtdconv.value = convites.qtdconv;
                                          visualizarConviteController.endDate
                                              .value = convites.datafinal;
                                          visualizarConviteController
                                              .idConv.value = convites.idconv;

                                          print(
                                              'data final ${convites.datafinal}');

                                          visualizarConviteController
                                              .getAConvite(convites.idconv);
                                        },
                                        child: Card(
                                          color: before
                                              ? Theme.of(context).buttonColor
                                              : Theme.of(context).accentColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              convites.titulo,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${convites.qtdconv} convidados',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.email_outlined,
                                                  size: 30,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.arrow_right,
                                                  size: 25,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                })
                            : ListView.builder(
                                itemCount: convitesController.convites.length,
                                itemBuilder: (_, i) {
                                  var convites = convitesController.convites[i];

                                  var date = DateTime.now();
                                  var endDate =
                                      DateTime.parse(convites.datafinal);
                                  var before = endDate.isBefore(date);
                                  return Container(
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          visualizarConviteController
                                              .titulo.value = convites.titulo;
                                          visualizarConviteController
                                              .qtdconv.value = convites.qtdconv;
                                          visualizarConviteController.endDate
                                              .value = convites.datafinal;
                                          visualizarConviteController
                                              .idConv.value = convites.idconv;

                                          print(
                                              'data final ${convites.datafinal}');

                                          visualizarConviteController
                                              .getAConvite(convites.idconv);
                                        },
                                        child: Card(
                                          color: before
                                              ? Theme.of(context).buttonColor
                                              : Theme.of(context).accentColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              convites.titulo,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${convites.qtdconv} convidados',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                              ),
                                            ),
                                            leading: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.email_outlined,
                                                  size: 30,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                ),
                                              ],
                                            ),
                                            trailing: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.arrow_right,
                                                  size: 30,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                      )),
                    ],
                  ),
                );
    });
  }
}
