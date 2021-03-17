import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onAlertButtonPressed(context, String text, String page) {
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
    title: text,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () {
          page != null ? Get.toNamed('$page') : Get.back();
        },
        width: 80,
        color: Color(0xff1A936F),
      )
    ],
  ).show();
}
