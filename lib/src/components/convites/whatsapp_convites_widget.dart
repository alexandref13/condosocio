import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
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
                'Envie este convite por whatsapp, para isto é necessário inserir o número no formato internacional. \n\ncódigo da área + seu número. \n\nex: 91XXXXXXXXX',
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
              child: TextField(
                keyboardType: TextInputType.number,
                controller: visualizarConvitesController.whatsappNumber.value,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      width: 1,
                    ),
                  ),
                  labelText: 'Telefone',
                  labelStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                      width: 1,
                    ),
                  ),
                ),
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
                        11) {
                      visualizarConvitesController.sendWhatsApp().then(
                        (value) {
                          if (value != 0) {
                            String message =
                                'Olá! você foi convidado pelo ${loginController.nome.value} morador do condomínio ${loginController.nomeCondo.value}. Agilize seu acesso clicando no link e preencha os campos em abertos. Grato! https://condosocio.com.br/paginas/acesso_visitante?chave=${value['idace']}';

                            FlutterOpenWhatsapp.sendSingleMessage(
                              '55${visualizarConvitesController.whatsappNumber.value.text}',
                              Uri.encodeFull(message),
                            );
                          } else {
                            onAlertButtonPressed(context,
                                'Algo deu errado\n Tente novamente', '/home');
                          }
                        },
                      );
                    } else {
                      onAlertButtonPressed(
                        context,
                        'O número está no formato errado \n ex: 91XXXXXXXXX',
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
