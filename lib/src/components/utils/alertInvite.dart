import 'package:flutter/material.dart';
import 'package:condosocio/src/components/utils/animated_dialog.dart';

void confirmedInviteAlert(
  BuildContext context,
  String text,
  String imagem,
  String button,
  VoidCallback onTap,
) {
  showScaledDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(seconds: 1),
    builder: (BuildContext context) {
      final size = MediaQuery.of(context).size;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        elevation: 0,
        child: SizedBox(
          height: size.height * 0.5, // mesma ideia do seu código
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(imagem, fit: BoxFit.contain),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(140, 44),
                ),
                child: Text(
                  button,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
