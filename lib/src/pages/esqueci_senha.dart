import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/email_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Esqueci extends StatefulWidget {
  @override
  _EsqueciState createState() => _EsqueciState();
}

class _EsqueciState extends State<Esqueci> {
  EmailController emailController = Get.put(EmailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Redefinir Senha',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return emailController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Form(
                        key: emailController.form,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                //color: Color(0xfff5f5f5),
                                child: Image.asset(
                                  'images/key.png',
                                  height: 230,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 30),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Informe o seu e-mail que iremos lhe enviar instruções para redefinir a senha.',
                                        style: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Container(
                                //color: Color(0xfff5f5f5),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  //enabled: !dependentesController.isLoading.value,
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!)),
                                    labelText: 'E-mail',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.red[500]!)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.red[500]!)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  ),
                                  keyboardType: TextInputType.emailAddress,

                                  validator: (valueEmail) {
                                    if (!EmailValidator.validate(valueEmail!)) {
                                      return 'Entre com e-mail válido!';
                                    }
                                    return null;
                                  },
                                  controller:
                                      emailController.emailesqueci.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 120),
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context)
                                            .colorScheme
                                            .secondary;
                                      },
                                    ),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        );
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    if (emailController.form.currentState!
                                        .validate()) {
                                      emailController
                                          .email(context)
                                          .then((value) {
                                        if (value == 1) {
                                          confirmedButtonPressed(
                                            context,
                                            "Enviamos um e-mail para a redefinição de senha. Aguarde!",
                                            "/login",
                                          );
                                        } else {
                                          onAlertButtonPressed(
                                              context,
                                              "E-mail não existe em nosso banco de dados!Tente novamente.",
                                              '',
                                              'images/error.png');
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Enviar",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
