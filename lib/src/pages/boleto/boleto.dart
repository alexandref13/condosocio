import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/boleto_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BoletoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    BoletoController boletoController = Get.put(BoletoController());
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Boleto 2º Via',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
        ),
        body: Obx(() {
          return boletoController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('images/2ViaBoleto.png'),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Text(
                                'Entre com e-mail e senha do sistema financeiro do condomínio'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Container(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: GoogleFonts.montserrat(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor)),
                                labelText: 'Entre com o e-mail',
                                labelStyle: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 14),
                                errorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Theme.of(context).accentColor)),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red[900])),
                                errorStyle: GoogleFonts.montserrat(
                                    color: Theme.of(context).errorColor),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (valueEmail) {
                                if (!EmailValidator.validate(valueEmail)) {
                                  return 'Entre com e-mail válido!';
                                }
                                return null;
                              },
                              controller: loginController.email.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Container(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: true,
                              style: GoogleFonts.montserrat(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor)),
                                labelText: 'Entre com a senha',
                                labelStyle: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 14),
                                errorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Theme.of(context).accentColor)),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red[900])),
                                errorStyle: GoogleFonts.montserrat(
                                    color: Theme.of(context).errorColor),
                              ),
                              validator: (valueSenha) {
                                if (valueSenha.isEmpty) {
                                  return 'Campo senha vazio!';
                                }
                                return null;
                              },
                              controller: loginController.password.value,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: ButtonTheme(
                            height: 50.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Theme.of(context).accentColor;
                                  },
                                ),
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>(
                                  (Set<MaterialState> states) {
                                    return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    );
                                  },
                                ),
                              ),
                              onPressed: () {
                                boletoController.sendBoleto();
                              },
                              child: Text(
                                "Entrar",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }));
  }
}
