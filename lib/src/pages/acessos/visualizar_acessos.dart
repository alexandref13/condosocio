import 'package:condosocio/src/components/visualizar_acessos/visualizar_acessos_entrada.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Feather.user_plus,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  onPressed: () {
                    Get.toNamed('/convites');
                  },
                ),
              ],
            )
          ],
          title: Text(
            'Acessos',
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            tabs: <Widget>[
              Text(
                'Entrada',
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
              Text(
                'Saída',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [VisualizarAcessosEntrada(), VisualizarAcessosEntrada()],
        ),
      ),
    );
  }
}
