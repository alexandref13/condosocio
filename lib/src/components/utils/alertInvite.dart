import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

confirmedInviteAlert(
    context, String text, String imagem, String button, VoidCallback onTap) {
  showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(seconds: 1),
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        child: Container(
          height: MediaQuery.of(context).size.height *
              0.5, // Ajuste a altura do container conforme necessário
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200, // Ajuste a altura da imagem conforme necessário
                child: Image.asset(
                  imagem,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20), // Adicione o padding lateral aqui
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: onTap,
                child: Text(
                  button,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
