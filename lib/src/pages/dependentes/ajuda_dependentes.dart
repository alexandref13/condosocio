import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AjudaDependentes extends StatelessWidget {
  const AjudaDependentes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
              appBar: AppBar(
                title: Text(
                  'Dependentes',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                centerTitle: true,
              ),
              body: Container(),
            ));
  }
}
