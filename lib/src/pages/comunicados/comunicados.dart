import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/comunicados/comunicados_controller.dart';
import 'package:condosocio/src/controllers/comunicados/visualizar_comunicados_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class Comunicados extends StatefulWidget {
  @override
  _ComunicadosState createState() => _ComunicadosState();
}

class _ComunicadosState extends State<Comunicados> {

  VisualizarComunicadosController visualizarComunicadosController =
      Get.put(VisualizarComunicadosController());
  ComunicadosController comunicadosController =
      Get.put(ComunicadosController());


  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    super.initState();
    comunicadosController.getComunicados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Comunicados',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return comunicadosController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Column(
                    children: [
                      boxSearch(
                          context,
                          visualizarComunicadosController.search.value,
                          visualizarComunicadosController.onSearchTextChanged),
                      Expanded(
                        child: _listaComunicados(),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  _listaComunicados() {
    if (comunicadosController.comunicados.length == 0) {
      return Stack(
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
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return SmartRefresher(
        controller: visualizarComunicadosController.refreshController,
        onRefresh: visualizarComunicadosController.onRefresh,
        onLoading: visualizarComunicadosController.onLoading,
        child: visualizarComunicadosController.searchResult.isNotEmpty ||
                visualizarComunicadosController.search.value.text.isNotEmpty
            ? Container(
                padding: EdgeInsets.all(8),
                child: ListView(
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: visualizarComunicadosController
                                .searchResult.length,
                            itemBuilder: (context, index) {
                              var search = visualizarComunicadosController
                                  .searchResult[index];
                              return GestureDetector(
                                onTap: () {
                                  /* comunicadosController.titulo.value =
                                  comunicados.titulo;
                              comunicadosController.arquivo.value =
                                  comunicados.texto;
                              comunicadosController.dia.value = comunicados.dia;
                              comunicadosController.mes.value = comunicados.mes;
                              
                              Get.toNamed('/detalhes');*/
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).accentColor,
                                  child: ListTile(
                                      leading: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: search.dia + "  ",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: search.mes,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                  letterSpacing: 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Container(
                                        child: Center(
                                          child: Text(
                                            search.titulo,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Feather.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        iconSize: 30,
                                        onPressed: () {
                                          launchInBrowser(
                                              "https://condosocio.com.br/acond/downloads/comunicados_arq/${search.arquivo}");
                                        },
                                      )),
                                ),
                              );
                            }))
                  ],
                ))
            : Container(
                padding: EdgeInsets.all(8),
                child: ListView(
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                            itemCount: comunicadosController.comunicados.length,
                            itemBuilder: (context, index) {
                              var comunicados =
                                  comunicadosController.comunicados[index];
                              return GestureDetector(
                                onTap: () {
                                  /* comunicadosController.titulo.value =
                                  comunicados.titulo;
                              comunicadosController.arquivo.value =
                                  comunicados.texto;
                              comunicadosController.dia.value = comunicados.dia;
                              comunicadosController.mes.value = comunicados.mes;
                              
                              Get.toNamed('/detalhes');*/
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).accentColor,
                                  child: ListTile(
                                      leading: RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: comunicados.dia + "  ",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                              text: comunicados.mes,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                  letterSpacing: 2),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Container(
                                    child: Center(
                                      child: Text(
                                            comunicados.titulo,
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                  ),
                                  trailing: IconButton(
                                        icon: Icon(Feather.download),
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        iconSize: 30,
                                        onPressed: () {
                                          launchInBrowser(
                                              "https://condosocio.com.br/acond/downloads/comunicados_arq/${comunicados.arquivo}");
                                        },
                                      )),
                                ),
                              );
                            }))
                  ],
            )),
      );
    }
  }
}
