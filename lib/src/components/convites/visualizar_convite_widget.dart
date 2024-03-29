import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarConvite extends StatefulWidget {
  @override
  _VisualizarConviteState createState() => _VisualizarConviteState();
}

class _VisualizarConviteState extends State<VisualizarConvite> {
  ConvitesController convitesController = Get.put(ConvitesController());

  @override
  void initState() {
    convitesController.getConvites();
    super.initState();
  }

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
                                  .selectionColor!,
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
                      Padding(padding: EdgeInsets.only(top: 20)),
                      boxSearch(
                          context,
                          convitesController.search.value,
                          convitesController.onSearchTextChanged,
                          "Pesquise o Convite..."),
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

                                          visualizarConviteController
                                              .getAConvite(convites.idconv);
                                        },
                                        child: Card(
                                          color: !before
                                              ? Theme.of(context)
                                                  .primaryColorDark
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            leading: RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: convites.dia + "  ",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  TextSpan(
                                                    text: convites.mes,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor!,
                                                        letterSpacing: 2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            title: Text(
                                              convites.titulo,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${convites.qtdconv} convidados',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
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
                                                      .selectionColor!,
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
                                          visualizarConviteController
                                              .acesso.value = convites.acesso;

                                          print('idconv ${convites.idconv}');

                                          visualizarConviteController
                                              .getAConvite(convites.idconv);
                                        },
                                        child: Card(
                                          color: before
                                              ? Theme.of(context)
                                                  .primaryColorDark
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListTile(
                                            leading: RichText(
                                              text: TextSpan(
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: convites.dia + "  ",
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  TextSpan(
                                                    text: convites.mes,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 14,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor!,
                                                        letterSpacing: 2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            title: Text(
                                              convites.titulo,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                            subtitle: Text(
                                              '${convites.qtdconv} convidados',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
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
                                                      .selectionColor!,
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
