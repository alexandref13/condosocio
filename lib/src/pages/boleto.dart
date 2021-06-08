import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/boleto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Boleto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BoletoController boletoController = Get.put(BoletoController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Boleto 2º Via',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Image(
              image: AssetImage('images/2ViaBoleto.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                "Entre com e-mail e senha do sistema financeiro do condomínio",
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: customTextField(
              context,
              'Email',
              null,
              false,
              1,
              true,
              boletoController.email.value,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: customTextField(
              context,
              'Senha',
              null,
              false,
              1,
              true,
              boletoController.password.value,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ButtonTheme(
              height: 50.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Theme.of(context).accentColor;
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      );
                    },
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "VISUALIZE",
                  style: GoogleFonts.montserrat(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
