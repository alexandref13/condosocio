import 'package:condosocio/src/pages/acheAqui/ache_aqui_page.dart';
import 'package:condosocio/src/pages/acheAqui/pesquisa_ache_aqui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcheAqui extends StatelessWidget {
  const AcheAqui({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ache Aqui'),
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            tabs: <Widget>[
              Text(
                'Temas',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Pesquisa',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AcheAquiPage(),
            PesquisaAcheAqui(),
          ],
        ),
      ),
    );
  }
}
