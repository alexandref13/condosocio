import 'dart:convert';

import 'package:condosocio/src/services/documentos/api_documentos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Documentos extends StatefulWidget {
  @override
  _DocumentosState createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  final Map<String, int> _documentCounts = {};

  @override
  void initState() {
    super.initState();
    _loadDocumentCounts();
  }

  Future<void> _loadDocumentCounts() async {
    final responses = await Future.wait([
      ApiDocumentos.getDocumentosAtas(),
      ApiDocumentos.getDocumentosConvencao(),
      ApiDocumentos.getDocumentosEdital(),
      ApiDocumentos.getDocumentosPrestacao(),
      ApiDocumentos.getDocumentosRegulamento(),
      ApiDocumentos.getDocumentosContratos(),
      ApiDocumentos.getDocumentosOutros(),
    ]);

    if (!mounted) return;

    setState(() {
      _documentCounts
        ..clear()
        ..addAll({
          'atas': _responseCount(responses[0]),
          'convencao': _responseCount(responses[1]),
          'editais': _responseCount(responses[2]),
          'prestacao': _responseCount(responses[3]),
          'regulamento': _responseCount(responses[4]),
          'contratos': _responseCount(responses[5]),
          'outros': _responseCount(responses[6]),
        });
    });
  }

  int _responseCount(dynamic response) {
    final decoded = json.decode(response.body);
    if (decoded is List) {
      return decoded.length;
    }
    return 0;
  }

  Widget _documentTile({
    required BuildContext context,
    required String label,
    required String route,
    required String countKey,
  }) {
    final count = _documentCounts[countKey];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              spreadRadius: 3,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Icon(
                        Icons.file_present,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (count != null)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  constraints: const BoxConstraints(minWidth: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    '$count',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Theme.of(context).primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Documentos',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: CondoNavBar(),
      body: Column(
        children: [
          Image.asset(
            'images/docimg.png',
            height: 200,
          ),
          Expanded(
            child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: <Widget>[
                        _documentTile(
                          context: context,
                          label: 'Atas',
                          route: '/ataDocumentos',
                          countKey: 'atas',
                        ),
                        _documentTile(
                          context: context,
                          label: 'Convenção',
                          route: '/convencaoDocumentos',
                          countKey: 'convencao',
                        ),
                        _documentTile(
                          context: context,
                          label: 'Editais',
                          route: '/editaisDocumentos',
                          countKey: 'editais',
                        ),
                        _documentTile(
                          context: context,
                          label: 'Prestação de Contas',
                          route: '/prestacaoDocumentos',
                          countKey: 'prestacao',
                        ),
                        _documentTile(
                          context: context,
                          label: 'Regulamento',
                          route: '/regulamentoDocumentos',
                          countKey: 'regulamento',
                        ),
                        _documentTile(
                          context: context,
                          label: 'Contratos',
                          route: '/contratosDocumentos',
                          countKey: 'contratos',
                        ),
                        Container(),
                        _documentTile(
                          context: context,
                          label: 'Outros',
                          route: '/outrosDocumentos',
                          countKey: 'outros',
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

