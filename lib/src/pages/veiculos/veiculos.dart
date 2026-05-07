import 'package:condosocio/src/pages/veiculos/adiciona_veiculos.dart';
import 'package:condosocio/src/pages/veiculos/visualizar_veiculos.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/veiculos/veiculos_controller.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Veiculos extends StatefulWidget {
  @override
  _VeiculosState createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  VeiculosController veiculosController = Get.put(VeiculosController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Coloque aqui o código que precisa ser executado ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Veículos',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor!,
              indicatorPadding: EdgeInsets.all(-4),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Theme.of(context)
                  .textSelectionTheme
                  .selectionColor!
                  .withOpacity(0),
              tabs: <Widget>[
                Text(
                  'Visualizar',
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!),
                ),
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CondoNavBar(),
          body: TabBarView(
            children: [
              VisualizarVeiculos(),
              AdicionaVeiculos(),
            ],
          ),
        ),
      ),
    );
  }
}

