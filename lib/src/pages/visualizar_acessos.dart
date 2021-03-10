import 'dart:convert';

import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/services/acessos/api_acessos_visualizacao.dart';
import 'package:condosocio/src/services/acessos/mapa_acessos_visualizacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessos extends StatefulWidget {
  @override
  _VisualizarAcessosState createState() => _VisualizarAcessosState();
}

class _VisualizarAcessosState extends State<VisualizarAcessos> {
  var acessos = List<MapaAcessosVisu>();
  List<MapaAcessosVisu> _searchResult = [];
  bool isLoading = true;
  TextEditingController search = TextEditingController();

  _getAcessos() {
    ApiAcessosVisualizacao.getAcessos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        acessos =
            lista.map((model) => MapaAcessosVisu.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    acessos.forEach((details) {
      if (details.pessoa.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(details);
    });

    setState(() {});
  }

  @override
  void initState() {
    _getAcessos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visualizar acessos',
        ),
      ),
      body: isLoading
          ? Container(
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).accentColor),
                  ),
                ),
              ),
            )
          : Column(
              children: [
                boxSearch(context, search, onSearchTextChanged),
                Container(
                  color: Theme.of(context).accentColor,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      Text(
                        'Nome',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      Text(
                        'Entrada',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      Text(
                        'Saída',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _listaVisualizarAcessos(),
                )
              ],
            ),
    );
  }

  void _configurandoModalBottomSheet(
      context,
      String day,
      String hour,
      String pessoa,
      String dayIn,
      String hourIn,
      String dayOut,
      String hourOut,
      String placa,
      String tipoDoc,
      String documento) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            padding: EdgeInsets.all(8),
            color: Theme.of(context).accentColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    pessoa,
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                  ),
                ),
                Container(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: placa == ''
                          ? Container()
                          : Text(
                              'Placa do carro: $placa',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Documento: $tipoDoc',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Numero do documento: $documento',
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor),
                      ),
                    ),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTheme(
                      height: 50.0,
                      child: RaisedButton(
                        elevation: 3,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.white,
                        ),
                        color: Color(0xFFD11A2A),
                      ),
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: RaisedButton(
                        elevation: 3,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Icon(
                          FontAwesome.heart,
                          size: 30,
                          color: Color(0xFFD11A2A),
                        ),
                        color: Colors.white,
                      ),
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: RaisedButton(
                        elevation: 3,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Icon(
                          FontAwesome.whatsapp,
                          size: 30,
                          color: Colors.white,
                        ),
                        color: Color(0xFF075e54),
                      ),
                    ),
                    ButtonTheme(
                      height: 50.0,
                      child: RaisedButton(
                        elevation: 3,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Icon(
                          FontAwesome.telegram,
                          size: 30,
                          color: Color(0xFF0088CC),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget _listaVisualizarAcessos() {
    return _searchResult.isNotEmpty || search.text.isNotEmpty
        ? ListView.builder(
            itemCount: _searchResult.length,
            itemBuilder: (context, index) {
              var search = _searchResult[index];
              var data = search.data;
              var cutDate = data.split(" ");
              var day = cutDate[0];

              var cuthour = cutDate[1].split("h<");
              var hour = cuthour[0];

              var dataEnt = search.dataent;
              var cutDataEnt = dataEnt.split('<');
              var dayIn = cutDataEnt[0];

              var cutHoraEnt = cutDataEnt[1].split('>');
              var hourIn = cutHoraEnt[1];

              var dataSai = search.datasai;
              var cutDataSai = dataSai.split('<');
              var dayOut = cutDataSai[0];

              var cutHoraSai = cutDataSai[1].split('>');
              var hourOut = cutHoraSai[1];
              return GestureDetector(
                onTap: () {
                  _configurandoModalBottomSheet(
                      context,
                      day,
                      hour,
                      search.pessoa,
                      dayIn,
                      hourIn,
                      dayOut,
                      hourOut,
                      search.placa,
                      search.tipodoc,
                      search.documento);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      )),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  day,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hour,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              search.pessoa,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  dayIn,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hourIn,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dayOut == ''
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    FontAwesome.clock_o,
                                    size: 40,
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        dayOut,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        hourOut,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: acessos.length,
            itemBuilder: (context, index) {
              var data = acessos[index].data;
              var cutDate = data.split(" ");
              var day = cutDate[0];

              var cuthour = cutDate[1].split("h<");
              var hour = cuthour[0];

              var dataEnt = acessos[index].dataent;
              var cutDataEnt = dataEnt.split('<');
              var dayIn = cutDataEnt[0];

              var cutHoraEnt = cutDataEnt[1].split('>');
              var hourIn = cutHoraEnt[1];

              var dataSai = acessos[index].datasai;
              var cutDataSai = dataSai.split('<');
              var dayOut = cutDataSai[0];

              var cutHoraSai = cutDataSai[1].split('>');
              var hourOut = cutHoraSai[1];
              return GestureDetector(
                onTap: () {
                  _configurandoModalBottomSheet(
                      context,
                      day,
                      hour,
                      acessos[index].pessoa,
                      dayIn,
                      hourIn,
                      dayOut,
                      hourOut,
                      acessos[index].placa,
                      acessos[index].tipodoc,
                      acessos[index].documento);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey),
                      )),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  day,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hour,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Text(
                              acessos[index].pessoa,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  dayIn,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  hourIn,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dayOut == ''
                              ? Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    FontAwesome.clock_o,
                                    size: 40,
                                    color: Theme.of(context).accentColor,
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        dayOut,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        hourOut,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
