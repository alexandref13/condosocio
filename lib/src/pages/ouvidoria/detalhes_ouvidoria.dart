import 'package:condosocio/src/controllers/ouvidoria/detalhes_ouvidoria/responda_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesOuvidoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RespondaController respondaController = Get.put(RespondaController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ouvidoria',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Container(),
      bottomSheet: Container(
        color: Theme.of(context).primaryColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Theme.of(context).accentColor,
                  ),
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).accentColor,
                    hintText: 'Envie uma resposta',
                    hintStyle: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25.0,
                color: Theme.of(context).accentColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
