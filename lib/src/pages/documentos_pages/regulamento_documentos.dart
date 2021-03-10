import 'dart:convert';

import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/services/documentos/api_documentos.dart';
import 'package:condosocio/src/services/documentos/mapa_documentos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Regulamento extends StatefulWidget {
  @override
  _RegulamentoState createState() => _RegulamentoState();
}

class _RegulamentoState extends State<Regulamento> {
  var regulamento = List<MapaDocumentos>();
  List<MapaDocumentos> _searchResult = [];
  bool isLoading = true;
  TextEditingController controller = TextEditingController();

  _getDocumentos() {
    ApiDocumentos.getDocumentosRegulamento().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        regulamento =
            lista.map((model) => MapaDocumentos.fromJson(model)).toList();
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _getDocumentos();
    super.initState();
  }

  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
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

  onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    regulamento.forEach((details) {
      if (details.nome.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(details);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Regulamento',
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
          : Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  boxSearch(context, controller, onSearchTextChanged),
                  Expanded(
                    child:
                        _searchResult.isNotEmpty || controller.text.isNotEmpty
                            ? ListView.builder(
                                itemCount: _searchResult.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        _searchResult[index].nome,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        _searchResult[index].data,
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
                                        onPressed: () => setState(
                                          () {
                                            _launched = _launchInBrowser(
                                                "https://condosocio.com.br/acond/downloads/documentos/${_searchResult[index].imgdoc}");
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: regulamento.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Theme.of(context).accentColor,
                                    child: ListTile(
                                      title: Text(
                                        regulamento[index].nome,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                        ),
                                      ),
                                      subtitle: Text(
                                        regulamento[index].data,
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
                                        onPressed: () => setState(
                                          () {
                                            _launched = _launchInBrowser(
                                                "https://condosocio.com.br/acond/downloads/documentos/${regulamento[index].imgdoc}");
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                  )
                ],
              ),
            ),
    );
  }
}
