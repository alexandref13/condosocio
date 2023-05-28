import 'package:condosocio/src/pages/ocorrencias/adicionar_ocorrencias.dart';
import 'package:condosocio/src/pages/ocorrencias/visualizar_ocorrencias.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../components/utils/alert_button_pressed.dart';

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
          leading: IconButton(
            onPressed: () {
              Get.offNamed('/home');
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Ocorrências',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.info_outline_rounded,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
              onPressed: () {
                onAlertButtonPressed(
                    context,
                    'Comunique qualquer ocorrência à administração do condomínio. Adicione uma imagem e um breve relato para ajudar na compreensão. Suas informações serão mantidas em sigilo e apenas a administração terá acesso. Use o app para acompanhar o andamento da sua ocorrência em tempo real. Fique tranquilo sabendo que sua demanda será atendida da melhor maneira possível.',
                    '',
                    '');
              },
            )
          ],
          bottom: TabBar(
            indicatorColor:
                Theme.of(context).textSelectionTheme.selectionColor!,
            indicatorPadding: EdgeInsets.all(-8),
            tabs: <Widget>[
              Text(
                'Visualizar',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
              ),
              Text(
                'Adicionar',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color:
                        Theme.of(context).textSelectionTheme.selectionColor!),
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

/*onAlertButtonPressed(context, String texto) {
  Alert(
    image: Icon(
      Icons.warning_sharp,
      color: Colors.orange,
      size: 50,
    ),
    style: AlertStyle(
      backgroundColor: Theme.of(context).textSelectionTheme.selectionColor!,
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
    title: texto,
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
        color: Theme.of(context).colorScheme.secondary,
      )
    ],
  ).show();
}*/
