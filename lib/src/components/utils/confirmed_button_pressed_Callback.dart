import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/utils/animated_dialog.dart';

void confirmedButtonPressed(BuildContext context, String text, String page) {
  showScaledDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 500),
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check, color: Colors.green, size: 60),
            const SizedBox(height: 10),
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
            onPressed: () {
              if (page.isNotEmpty) {
                Get.offNamedUntil(page, ModalRoute.withName(page));
              } else {
                Get.back();
              }
            },
            child: Text(
              'OK',
              style: GoogleFonts.montserrat(color: Colors.green, fontSize: 18),
            ),
          ),
        ],
      );
    },
  );
}
