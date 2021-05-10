import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
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
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WhatsApp',
          style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Theme.of(context).textSelectionTheme.selectionColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(
                'images/landing1.png',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'Envie este convite por whatsapp, para isto é necessário inserir o número no formato internacional. \n\nCódigo do país + código da área + seu número. \n\nex: 5591XXXXX-XXXX',
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
                      visualizarConvitesController.sendWhatsApp().then(
                        (value) {
                          if (value != 0) {
                            FlutterOpenWhatsapp.sendSingleMessage(
                              visualizarConvitesController
                                  .whatsappNumber.value.text,
                              'ola',
                            );

                            // visualizarConvitesController.launched =
                            //     visualizarConvitesController.launchInBrowser(
                            //         'https://api.whatsapp.com/send?phone=${visualizarConvitesController.whatsappNumber.value.text}&text=Olá!%20você%20foi%20convidadopelo%20${loginController.nome.value}%20morador%20do%20condomínio%20${loginController.nomeCondo.value}.%20Agilize%20seu%20acesso%20clicando%20no%20link%20e%20preencha%20os%20campos%20em%20abertos.%20Grato!%20https://condosocio.com.br/paginas/acesso_visitante?chave=${value['idace']}');
                          } else {
                            onAlertButtonPressed(context,
                                'Algo deu errado\n Tente novamente', '/home');
                          }
                        },
                      );
                    } else {
                      onAlertButtonPressed(
                        context,
                        'O número está no formato errado \n ex: 5591XXXXXXXXX',
                        null,
                      );
                    }
                  },
                  child: Text(
                    'ENVIAR',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}