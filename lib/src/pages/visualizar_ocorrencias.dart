import 'dart:convert';

import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:condosocio/src/services/ocorrencias/map_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarOcorrencias extends StatefulWidget {
  @override
  _VisualizarOcorrenciasState createState() => _VisualizarOcorrenciasState();
}

class _VisualizarOcorrenciasState extends State<VisualizarOcorrencias> {
  var ocorrencias = List<MapaOcorrencias>();
  List<MapaOcorrencias> _searchResult = [];
  bool isLoading = true;
  TextEditingController search = TextEditingController();

  _getOcorrencias() {
    ApiOcorrencias.getOcorrencias().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        ocorrencias =
            lista.map((model) => MapaOcorrencias.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getOcorrencias();
  }

  onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    ocorrencias.forEach((details) {
      if (details.titulo.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(details);
    });

    setState(() {});
  }

  void _configurandoModalBottomSheet(
    context,
    String data,
    String hora,
    String titulo,
    String dataoco,
    String horaoco,
    String status,
  ) {
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
                    titulo,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Data da ocorrência',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            Text(
                              dataoco,
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hora da ocorrência',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                            Text(
                              horaoco,
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: status == '1'
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ocorrencia Finalizada',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor),
                                    ),
                                    Icon(
                                      Feather.check,
                                      size: 40,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ocorrencia em andamento',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor),
                                    ),
                                    Icon(
                                      Feather.alert_triangle,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                  ],
                                )),
                    ],
                  ),
                ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Ocorrencias'),
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
                        'Titulo',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      Text(
                        'Ocorrido',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                      Text(
                        'Status',
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
                  child: _searchResult.length != 0 || search.text.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResult.length,
                          itemBuilder: (context, index) {
                            var ocorrencia = _searchResult[index];
                            return GestureDetector(
                              onTap: () {
                                _configurandoModalBottomSheet(
                                    context,
                                    ocorrencia.data,
                                    ocorrencia.hora,
                                    ocorrencia.titulo,
                                    ocorrencia.dataoco,
                                    ocorrencia.horaoco,
                                    ocorrencia.status);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                )),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            ocorrencia.data,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ocorrencia.hora,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Text(
                                        ocorrencia.titulo,
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
                                            ocorrencia.dataoco,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ocorrencia.horaoco,
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
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        FontAwesome.clock_o,
                                        size: 40,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: ocorrencias.length,
                          itemBuilder: (context, index) {
                            var ocorrencia = ocorrencias[index];
                            return GestureDetector(
                              onTap: () {
                                _configurandoModalBottomSheet(
                                    context,
                                    ocorrencia.data,
                                    ocorrencia.hora,
                                    ocorrencia.titulo,
                                    ocorrencia.dataoco,
                                    ocorrencia.horaoco,
                                    ocorrencia.status);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                )),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            ocorrencia.data,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ocorrencia.hora,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Text(
                                        ocorrencia.titulo,
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
                                            ocorrencia.dataoco,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ocorrencia.horaoco,
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
                                      padding: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        ocorrencia.status == '1'
                                            ? Feather.check
                                            : Feather.alert_triangle,
                                        size: 40,
                                        color: ocorrencia.status == '1'
                                            ? Theme.of(context).accentColor
                                            : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
