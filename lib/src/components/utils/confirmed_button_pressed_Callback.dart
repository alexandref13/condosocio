import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

confirmedButtonPressed(context, String text, String page) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(seconds: 1),
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        // Definir a cor de fundo desejada
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.error,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              "OK",
              style: GoogleFonts.montserrat(
                color: Colors.green,
                fontSize: 18,
              ),
            ),
            onPressed: () {
              if (page != '') {
                Get.offNamedUntil('$page', ModalRoute.withName('$page'));
              } else {
                Get.back();
              }
            },
          ),
        ],
      );
    },
  );
}
