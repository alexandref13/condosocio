import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/whatsapp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onWhatsappButtonPressed(context, String page) {
  WhatsappController whatsappController = Get.put(WhatsappController());
  LoginController loginController = Get.put(LoginController());
  var nome = loginController.nome.value.split(' ');
  Alert(
    image: Icon(
      Icons.highlight_off,
      color: Color(0xff1A936F),
      size: 60,
    ),
    style: AlertStyle(
      backgroundColor: Theme.of(context).accentColor,
      animationType: AnimationType.fromTop,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      //descStyle: GoogleFonts.poppins(color: Colors.red,),
      animationDuration: Duration(milliseconds: 300),
      titleStyle: GoogleFonts.poppins(
        color: Theme.of(context).textSelectionTheme.selectionColor,
        fontSize: 18,
      ),
    ),
    context: context,
    title:
        'Sua autorização foi enviada à portaria. Para agilizar o acesso deseja enviar convite ao seu visitante?',
    buttons: [
      DialogButton(
        child: Text(
          "Cancelar",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          page != null ? Get.offAllNamed('$page') : Get.back();
        },
        width: 80,
        color: Color(0xffa3000b),
      ),
      DialogButton(
        child: Text(
          "Ok",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          whatsappController.launched = whatsappController.launchInBrowser(
            'https://api.whatsapp.com/send?phone=5591981220670_blank&text=Olá!%20você%20foi%20convidado%20pelo%20${nome[0]}%20morador%20do%20condomínio%20${loginController.nomeCondo.value}.%20Agilize%20seu%20acesso%20clicando%20no%20link%20e%20preencha%20os%20campos%20em%20abertos.%20Grato!%20https://condosocio.com.br/paginas/acesso_visitante?chave=NzcxMjgy',
          );
        },
        width: 80,
        color: Color(0xff1A936F),
      )
    ],
  ).show();
}
