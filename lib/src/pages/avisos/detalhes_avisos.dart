import 'package:condosocio/src/controllers/avisos/avisos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';

class DetalhesAvisos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AvisosController avisosController = Get.put(AvisosController());

    var text = avisosController.texto.value.split('<table');

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            avisosController.titulo.value,
            style: GoogleFonts.montserrat(
                fontSize: 14, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                  child: Html(
                    data: text[0],
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
                      "li": Style(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
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
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor)
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
