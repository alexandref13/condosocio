import 'package:condosocio/src/controllers/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/ouvidoria/detalhes_ouvidoria/responda_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RespondaOuvidoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RespondaController respondaController = Get.put(RespondaController());
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Responda: ',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            customTextField(
              context,
              '',
              '',
              true,
              5,
              true,
              respondaController.controller.value,
            ),
            SizedBox(
              height: 10,
            ),
            ButtonTheme(
              height: 70.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Theme.of(context).accentColor;
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                      return 3;
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                    (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      );
                    },
                  ),
                ),
                onPressed: () {
                  respondaController.sendRespondaOuvidoria().then((value) {
                    if (value == 1) {
                      onAlertButtonPressed(
                          context, 'Enviado com sucesso!', null);
                    } else if (value == 'vazio') {
                      onAlertButtonPressed(
                          context, 'O campo de texto é obrigátorio', null);
                    } else {
                      onAlertButtonPressed(
                          context, 'Algo deu errado! \nTente novamente', null);
                    }
                  });
                },
                child: respondaController.isLoading.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : Text(
                        "Enviar",
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
