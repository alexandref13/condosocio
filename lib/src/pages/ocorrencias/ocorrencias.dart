import 'package:condosocio/src/pages/ocorrencias/adicionar_ocorrencias.dart';
import 'package:condosocio/src/pages/ocorrencias/visualizar_ocorrencias.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Ocorrencias extends StatefulWidget {
  @override
  _OcorrenciasState createState() => _OcorrenciasState();
}

class _OcorrenciasState extends State<Ocorrencias> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ocorrências',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            tabs: <Widget>[
              Text(
                'Adicionar',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Visualizar',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [AdicionarOcorrencias(), VisualizarOcorrencias()],
        ),
      ),
    );
  }
}
