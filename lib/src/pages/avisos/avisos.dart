import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/avisos/avisos_controller.dart';
import 'package:condosocio/src/controllers/avisos/visualizar_avisos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Avisos extends StatefulWidget {
  @override
  _AvisosState createState() => _AvisosState();
}

class _AvisosState extends State<Avisos> {
  VisualizarAvisosController visualizarAvisosController =
      Get.put(VisualizarAvisosController());

  AvisosController avisosController = Get.put(AvisosController());

  @override
  void initState() {
    super.initState();
    avisosController.getAvisos();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offNamed('/home');
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Avisos',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return avisosController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Column(
                    children: [
                      boxSearch(
                          context,
                          visualizarAvisosController.search.value,
                          visualizarAvisosController.onSearchTextChanged,
                          "Pesquise os Avisos..."),
                      Expanded(
                        child: _listaavisos(),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  _listaavisos() {
    if (avisosController.avisos!.length == 0) {
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
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
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
          controller: visualizarAvisosController.refreshController,
          onRefresh: visualizarAvisosController.onRefresh,
          onLoading: visualizarAvisosController.onLoading,
          child: visualizarAvisosController.searchResult.isNotEmpty ||
                  visualizarAvisosController.search.value.text.isNotEmpty
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
                              itemCount: visualizarAvisosController
                                  .searchResult.length,
                              itemBuilder: (context, index) {
                                var search = visualizarAvisosController
                                    .searchResult[index];

                                return GestureDetector(
                                  onTap: () {
                                    avisosController.titulo.value =
                                        search.titulo;
                                    avisosController.texto.value = search.texto;
                                    avisosController.dia.value = search.dia;
                                    avisosController.mes.value = search.mes;
                                    avisosController.hora.value = search.hora;
                                    Get.toNamed('/detalhesaviso');
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                                        .selectionColor!,
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
                                                      .selectionColor!,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_right,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          size: 30,
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
                              itemCount: avisosController.avisos!.length,
                              itemBuilder: (context, index) {
                                var avisos = avisosController.avisos![index];
                                return GestureDetector(
                                  onTap: () {
                                    avisosController.titulo.value =
                                        avisos.titulo;
                                    avisosController.texto.value = avisos.texto;
                                    avisosController.dia.value = avisos.dia;
                                    avisosController.mes.value = avisos.mes;
                                    avisosController.hora.value = avisos.hora;
                                    Get.toNamed('/detalhesaviso');
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                                  text: avisos.dia + "  ",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                text: avisos.mes,
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
                                        title: Container(
                                          child: Center(
                                            child: Text(
                                              avisos.titulo,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        trailing: Icon(
                                          Icons.arrow_right,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          size: 30,
                                        )),
                                  ),
                                );
                              }))
                    ],
                  )));
    }
  }
}
