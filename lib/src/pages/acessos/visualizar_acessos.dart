import 'package:condosocio/src/components/acessos_saidas/widget_saida_acessos.dart';
import 'package:condosocio/src/components/visualizar_acessos/visualizar_acessos_entrada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          Get.offNamed('/home');
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
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
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor,
              tabs: <Widget>[
                Text(
                  'Entrada',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                ),
                Text(
                  'Saída',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [VisualizarAcessosEntrada(), SaidaAcessos()],
          ),
        ),
      ),
    );
  }
}
