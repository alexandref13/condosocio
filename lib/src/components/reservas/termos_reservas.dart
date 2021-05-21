import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';

class TermosReservas extends StatelessWidget {
  final ReservasController reservasController = Get.put(ReservasController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Html(
          data: reservasController.termo.value,
          style: {
            'img': Style(
              width: 400,
              height: 400,
              backgroundColor: Colors.red,
            ),
            "h3": Style(
              fontFamily: 'montserrat',
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontSize: FontSize(14),
            ),
            "h1": Style(
                fontFamily: 'montserrat',
                fontSize: FontSize(14),
                color: Theme.of(context).textSelectionTheme.selectionColor),
            "p": Style(
              fontFamily: 'montserrat',
              fontSize: FontSize(14),
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
            "li": Style(
                fontFamily: 'montserrat',
                fontSize: FontSize(14),
                color: Theme.of(context).textSelectionTheme.selectionColor,
                display: Display.BLOCK),
            "a": Style(
              fontFamily: 'montserrat',
              fontSize: FontSize(14),
              color: Theme.of(context).textSelectionTheme.selectionColor,
              textDecoration: TextDecoration.none,
            ),
            "h2": Style(
                fontFamily: 'montserrat',
                fontSize: FontSize(14),
                color: Theme.of(context).textSelectionTheme.selectionColor)
          },
        ),
      ),
    );
  }
}
