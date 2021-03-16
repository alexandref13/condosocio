import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onAlertButtonPressed(context, String text) {
  Alert(
    image: Icon(
      Icons.highlight_off,
      color: Color(0xff1A936F),
      size: 60,
    ),
    style: alertStyle,
    context: context,
    title: text,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        onPressed: () => Navigator.pop(context),
        width: 80,
        color: Color(0xff1A936F),
      )
    ],
  ).show();
}

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  //descStyle: GoogleFonts.poppins(color: Colors.red,),
  animationDuration: Duration(milliseconds: 300),
  titleStyle: GoogleFonts.poppins(
    color: Colors.black,
    fontSize: 18,
  ),
);
