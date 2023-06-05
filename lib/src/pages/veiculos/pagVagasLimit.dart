import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VagasLimit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 100, 10, 20),
            child: Text(
              'Número de vagas excedidas!',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              ' Exclua algum veículo ou procure a administração do seu condomínio.',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(bottom: 120),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .70,
              child: Image.asset(
                'images/vagas.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
