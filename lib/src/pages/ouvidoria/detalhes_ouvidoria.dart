import 'package:flutter/material.dart';
import 'package:condosocio/src/components/detalhes_ouvidoria/resposta_ouvidoria.dart';
import 'package:condosocio/src/components/detalhes_ouvidoria/responda_ouvidoria.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesOuvidoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ouvidoria',
            style: GoogleFonts.montserrat(fontSize: 20),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Text(
                'Respostas',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Responda',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [RespostaOuvidoria(), RespondaOuvidoria()],
        ),
      ),
    );
  }
}
