import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/pages/dependentes/adiciona_dependentes.dart';
import 'package:condosocio/src/pages/dependentes/visualizar_dependentes.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dependentes extends StatefulWidget {
  @override
  _DependentesState createState() => _DependentesState();
}

class _DependentesState extends State<Dependentes> {
  DependentesController dependentesController =
      Get.put(DependentesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Dependentes',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  AntDesign.infocirlce,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor,
              tabs: <Widget>[
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
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
              children: [AdicionaDependentes(), VisualizarDependentes()]),
        ),
      ),
    );
  }
}
