import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class Detalhes extends StatefulWidget {
  String titulo;
  String texto;
  String dia;
  String mes;
  String hora;

  Detalhes(this.titulo, this.texto, this.dia, this.mes, this.hora);
  @override
  _DetalhesState createState() => _DetalhesState();
}

class _DetalhesState extends State<Detalhes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${widget.titulo}',
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
                data: widget.texto,
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
