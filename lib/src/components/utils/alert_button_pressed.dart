import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

onAlertButtonPressed(context, String text, String page, String img) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(seconds: 1),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white, // Definir a cor de fundo desejada
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              img != null
                  ? Image.asset(
                      "images/error.png",
                      width: 50, // Defina o tamanho desejado da imagem
                    )
                  : Container(),
              SizedBox(height: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              DialogButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  if (page != null) {
                    Get.offNamedUntil('$page', ModalRoute.withName('$page'));
                  } else {
                    Get.back();
                  }
                },
                width: 80,
                color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
        ),
      );
    },
  );
}
