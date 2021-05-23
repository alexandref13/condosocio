import 'package:condosocio/src/pages/ocorrencias/respostaOcorrencia/detalhes_ocorrencias_widget.dart';
import 'package:condosocio/src/pages/ocorrencias/respostaOcorrencia/responda_ocorrencia_widget.dart';
import 'package:condosocio/src/pages/ocorrencias/respostaOcorrencia/resposta_ocorrencia_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RespostaOcorrencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ocorrencias',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            tabs: <Widget>[
              Text(
                'Detalhes',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Resposta',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              Text(
                'Responda',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DetalhesOcorrenciasWidget(),
            RespostaOcorrenciaWidget(),
            RespondaOcorrenciaWidget(),
          ],
        ),
      ),
    );
  }
}
