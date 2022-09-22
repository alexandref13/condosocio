import 'package:condosocio/src/pages/ocorrencias/adicionar_ocorrencias.dart';
import 'package:condosocio/src/pages/ocorrencias/visualizar_ocorrencias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          actions: [
            IconButton(
              icon: Icon(
                AntDesign.infocirlce,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onPressed: () {
                onAlertButtonPressed(context,
                    'Faça ocorrências à administração do seu condomínio. Você pode inclusive incluir uma imagem e fazer uma breve relato sobre o ocorrido.\nLembramos que isto será privado, apenas a administração (síndico e administradores) terão acesso as informações prestadas.\nAcompanhe o andamento das suas ocorrências pelo app.');
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: Theme.of(context).textSelectionTheme.selectionColor,
            tabs: <Widget>[
              Text(
                'Visualizar',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              Text(
                'Adicionar',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [VisualizarOcorrencias(), AdicionarOcorrencias()],
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
        color: Theme.of(context).accentColor,
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
