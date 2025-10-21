import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:condosocio/src/components/utils/animated_dialog.dart'; // <- helper com showScaledDialog

void deleteAlert(BuildContext context, String text, VoidCallback onOk) {
  showScaledDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 500),
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      final bg = theme.textSelectionTheme.selectionColor ?? Colors.white;

      return Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: bg,
          titleTextStyle: GoogleFonts.poppins(
            color: theme.colorScheme.secondary,
            fontSize: 18,
          ),
          title: Column(
            children: [
              const Icon(Icons.warning, color: Colors.orange, size: 60),
              const SizedBox(height: 10),
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.secondary,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // --- Responsivo e simples: Wrap quebra linha quando faltar espaço ---
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 12, // espaço horizontal entre os botões
            runSpacing: 12, // espaço vertical quando quebrar de linha
            children: [
              SizedBox(
                width: 160, // use 140~180 se preferir; pode remover pra auto
                child: DialogButton(
                  color: theme.primaryColor,
                  onPressed: onOk,
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: bg,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 160,
                child: DialogButton(
                  color: theme.colorScheme.error,
                  onPressed: Get.back,
                  child: Text(
                    "CANCELAR",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: bg,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
