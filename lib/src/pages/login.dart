import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Login extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                ),
                child: Column(children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 75),
                      child: Image.asset(
                        "images/condosocio_logo.png",
                        fit: BoxFit.fill,
                        width: 150,
                      ),
                    ),
                  ),
                ])),
            Positioned(
              top: 200,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
              ),
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 310, 20, 20),
                          child: Container(
                            child: TextFormField(
                              style: GoogleFonts.poppins(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              decoration: InputDecoration(
                                enabled: !loginController.isLoading.value,
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
                                labelText: 'Entre com seu e-mail',
                                prefixIcon: Icon(Icons.mail_outline,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                                labelStyle: GoogleFonts.poppins(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontSize: 16),
                                errorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Theme.of(context).accentColor)),
                                focusedErrorBorder: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: Theme.of(context).accentColor)),
                                errorStyle: GoogleFonts.poppins(
                                    color: Theme.of(context).accentColor),
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
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                          child: Container(
                            child: TextFormField(
                              obscureText: true,
                              style: GoogleFonts.poppins(
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                              decoration: InputDecoration(
                                  enabled: !loginController.isLoading.value,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xffF3E9D2), width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor)),
                                  labelText: 'Entre com a senha',
                                  prefixIcon: Icon(Icons.lock_outline,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor),
                                  labelStyle: GoogleFonts.poppins(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontSize: 16),
                                  errorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color:
                                              Theme.of(context).accentColor)),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color:
                                              Theme.of(context).accentColor)),
                                  errorStyle: GoogleFonts.poppins(
                                      color: Theme.of(context).accentColor)),
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
                                if (_formKey.currentState.validate()) {
                                  loginController.login().then(
                                    (value) {
                                      if (value == null) {
                                        onAlertButtonPressed(
                                            context,
                                            'Email ou senha invalivos \n Tente novamente',
                                            null);
                                      } else {
                                        Get.toNamed('/home');
                                      }
                                    },
                                  );
                                }
                              },
                              child: loginController.isLoading.value
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "Entrar",
                                      style: GoogleFonts.poppins(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor,
                                          fontSize: 20),
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: ButtonTheme(
                            height: 50,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) =>
                                      Theme.of(context).accentColor,
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
                              onPressed: () {},
                              child: Text(
                                "Esqueceu a senha?",
                                style: GoogleFonts.poppins(
                                  fontSize: 14.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                                textDirection: TextDirection.ltr,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
