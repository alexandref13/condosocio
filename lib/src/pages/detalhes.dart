import 'package:condosocio/src/controllers/comunicados_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class DetalhesComunicados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ComunicadosController comunicadosController =
        Get.put(ComunicadosController());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              comunicadosController.titulo.value,
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Html(
                data: comunicadosController.texto.value,
                style: {
                  "h3": Style(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                  "h1": Style(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                  "p": Style(
                      fontFamily: 'Poppins',
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor),
                  "li": Style(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      display: Display.BLOCK),
                  "a": Style(
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    textDecoration: TextDecoration.none,
                  ),
                  "h2": Style(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor)
                },
              ),
            ),
          )),
    );
  }
}
