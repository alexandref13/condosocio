import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

void deleteAlert(BuildContext context, String text, VoidCallback function) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 500),
    builder: (BuildContext context) {
      return Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Theme.of(context).textSelectionTheme.selectionColor!,
          titleTextStyle: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 18,
          ),
          title: Container(
            child: Column(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.orange,
                  size: 60,
                ),
                SizedBox(height: 10),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: function,
                    width: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(width: 20),
                  DialogButton(
                    child: Text(
                      "CANCELAR",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor!,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    width: 100,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
