import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';

class TermosReservas extends StatelessWidget {
  final ReservasController reservasController = Get.put(ReservasController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Termo de Uso",
          style:
              GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Html(
                  data: reservasController.termo.value,
                  style: {
                    "h3": Style(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    "h1": Style(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    "p": Style(
                      fontFamily: 'montserrat',
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    "span": Style(
                      fontFamily: 'montserrat',
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                    "li": Style(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        display: Display.block),
                    "a": Style(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      textDecoration: TextDecoration.none,
                    ),
                    "h2": Style(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor),
                    "table": Style(
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor)
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
