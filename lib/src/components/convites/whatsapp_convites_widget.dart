import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class WhatsAppConvitesWidget extends StatelessWidget {
  const WhatsAppConvitesWidget({Key? key}) : super(key: key);

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
              color: Theme.of(context).textSelectionTheme.selectionColor!),
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
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'O número de telefone fornecido não está no formato correto para o WhatsApp.\n\nEX: +55 (99) 9 9999-9999.\n\nPor favor, insira o número novamente abaixo:',
                style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color:
                        Theme.of(context).textSelectionTheme.selectionColor!),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: IntlPhoneField(
                invalidNumberMessage: 'Número inválido',
                searchText: 'Procure pelo País',
                dropdownTextStyle: GoogleFonts.montserrat(
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                    fontSize: 16),
                dropdownIcon: Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                controller: visualizarConvitesController.whatsappNumber.value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context)
                            .textSelectionTheme
                            .selectionColor!,
                        width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!)),
                  labelText: 'Celular',
                  labelStyle: GoogleFonts.montserrat(
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
                      fontSize: 14),
                  errorBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red[400]!)),
                  focusedErrorBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.red[700]!)),
                  errorStyle: GoogleFonts.montserrat(color: Colors.red[400]!),
                  helperStyle: TextStyle(color: Colors.red[400]!),
                  counterText: '',
                ),
                style: GoogleFonts.montserrat(
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                    fontSize: 16),
                initialCountryCode: 'BR',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                onCountryChanged: (country) {
                  print('Mudar para: ' + country.name);
                },
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
                        return Theme.of(context).colorScheme.secondary;
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
                      visualizarConvitesController.sendWhatsApp().then((value) {
                        if (value != 0) {
                          String message =
                              'Olá! Você foi convidado por ${loginController.nome.value}, morador do condomínio ${loginController.nomeCondo.value}. Agilize seu acesso clicando no link e preencha os campos em aberto. Grato! https://www.condosocio.com.br/paginas/a.php?chave=${value['idace']}';

                          whatsAppSend(
                            context,
                            visualizarConvitesController
                                .whatsappNumber.value.text,
                            Uri.encodeFull(message),
                          );
                        } else {
                          onAlertButtonPressed(
                            context,
                            'Algo deu errado. Tente novamente.',
                            '/home',
                            'images/error.png',
                          );
                        }
                      });
                    }
                  },
                  child: Text(
                    'ENVIAR',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor!,
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
