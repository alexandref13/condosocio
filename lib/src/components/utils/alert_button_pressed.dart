import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:condosocio/src/components/utils/animated_dialog.dart';

void onAlertButtonPressed(
    BuildContext context, String text, String page, String img) {
  showScaledDialog(
    // <— substitui showAnimatedDialog
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 500),
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (img.isNotEmpty)
                Image.asset(
                  img,
                  width: 60,
                ),
              const SizedBox(height: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.error,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              DialogButton(
                child: Text(
                  "OK",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                onPressed: () {
                  if (page.isNotEmpty) {
                    Get.offNamedUntil(page, ModalRoute.withName(page));
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
