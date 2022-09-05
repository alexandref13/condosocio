import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/pages/dependentes/adiciona_dependentes.dart';
import 'package:condosocio/src/pages/dependentes/visualizar_dependentes.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
              'Usuários',
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
                onPressed: () {
                  onAlertButtonPressed(context,
                      'Você poderá adicionar até 06 (seis) dependentes.\nLembramos que os dependentes são necessariamente moradores.\nSe você descumprir esta norma, estará sujeito às penalidades dispostas no Regulamento Interno e ou Convenção do condomínio.\nPara adicionar dependentes além do permitido, você deverá solicitar à administração condominial.');
                },
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

onAlertButtonPressed(context, String text) {
  Alert(
    image: Icon(
      Icons.close,
      color: Colors.white,
      size: 60,
    ),
    style: AlertStyle(
      backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      //descStyle: GoogleFonts.poppins(color: Colors.red,),
      animationDuration: Duration(milliseconds: 300),
      titleStyle: GoogleFonts.poppins(
        color: Theme.of(context).colorScheme.secondary,
        fontSize: 14,
      ),
    ),
    context: context,
    title: text,
    buttons: [
      DialogButton(
        child: Text(
          "Fechar",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        width: 80,
        color: Theme.of(context).accentColor,
      )
    ],
  ).show();
}
