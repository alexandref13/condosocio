import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WhatsAppConvitesWidget extends StatelessWidget {
  const WhatsAppConvitesWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Text(
              'Para o envio do convite por WhatsApp, é necessário enviar o número no formato internacional. \n\nCódigo do país + código da área e seu número. \n\nex: 55 91 XXXXXXXXX',
              style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: customTextField(
              context,
              'Telefone',
              null,
              false,
              1,
              true,
              visualizarConvitesController.whatsappNumber.value,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            width: MediaQuery.of(context).size.width,
            child: ButtonTheme(
              height: 50.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Theme.of(context).accentColor;
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      return 2;
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
                onPressed: () {
                  if (visualizarConvitesController
                          .whatsappNumber.value.text.length ==
                      13) {
                    FlutterOpenWhatsapp.sendSingleMessage(
                      visualizarConvitesController.whatsappNumber.value.text,
                      'ola',
                    );
                  } else {
                    onAlertButtonPressed(
                      context,
                      'O número está no formato errado \n ex: 55 91 XXXXXXXXX',
                      null,
                    );
                  }
                },
                child: Text(
                  'ENVIAR',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
