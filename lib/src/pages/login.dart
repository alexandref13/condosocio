import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Login extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());
  final ThemeController themeController = Get.put(ThemeController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Stack(
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
                          padding: const EdgeInsets.only(top: 90),
                          child: Image.asset(
                            "images/condosocio_logo.png",
                            fit: BoxFit.fill,
                            width: 120,
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                            color:
                                                Theme.of(context).accentColor)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.red[900])),
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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
                                            color:
                                                Theme.of(context).accentColor)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.red[900])),
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
                            Container(
                              padding: EdgeInsets.fromLTRB(7, 0, 0, 0),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: loginController.isChecked.value,
                                        onChanged: (bool value) {
                                          loginController.isChecked.value =
                                              value;
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text.rich(TextSpan(
                                              text: 'Li e concordo com os ',
                                              style: GoogleFonts.montserrat(
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                  fontSize: 12),
                                              children: [
                                                TextSpan(
                                                  text: 'Termos de Uso ',
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.amber,
                                                      fontSize: 12),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          loginController
                                                                  .launched =
                                                              loginController
                                                                  .launchInBrowser(
                                                            'https://condosocio.com.br/termo.html',
                                                          );
                                                        },
                                                ),
                                                TextSpan(
                                                  text: 'e com a ',
                                                  style: GoogleFonts.montserrat(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontSize: 12),
                                                ),
                                                TextSpan(
                                                  text:
                                                      'Política de Privacidade',
                                                  style: GoogleFonts.montserrat(
                                                      color: Colors.amber,
                                                      fontSize: 12),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          loginController
                                                                  .launched =
                                                              loginController
                                                                  .launchInBrowser(
                                                            'https://condosocio.com.br/privacidade.html',
                                                          );
                                                        },
                                                ),
                                              ])),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).accentColor;
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
                                    if (loginController.isChecked.value) {
                                      if (loginController.email.value.text ==
                                              '' ||
                                          loginController.password.value.text ==
                                              '') {
                                        onAlertButtonPressed(
                                          context,
                                          'Campo e-mail ou senha vazio!',
                                          null,
                                        );
                                      }
                                      if (_formKey.currentState.validate()) {
                                        loginController.login().then(
                                          (value) {
                                            if (value == null) {
                                              loginController
                                                  .password.value.text = '';
                                              onAlertButtonPressed(
                                                context,
                                                'Email ou senha inválidos! \n Tente novamente',
                                                null,
                                              );
                                            } else {
                                              loginController
                                                  .hasMoreEmail(
                                                loginController
                                                    .email.value.text,
                                              )
                                                  .then(
                                                (response) {
                                                  if (response.length > 1) {
                                                    Get.toNamed('/listOfCondo');
                                                  } else {
                                                    loginController.id.value =
                                                        value['idusu'];
                                                    loginController
                                                            .idcond.value =
                                                        value['idcond'];
                                                    loginController.tipo.value =
                                                        value['tipo'];
                                                    loginController
                                                            .imgperfil.value =
                                                        value['imgperfil'];
                                                    loginController.emailUsu
                                                        .value = value['email'];
                                                    loginController
                                                            .nomeCondo.value =
                                                        value['nome_condo'];
                                                    loginController
                                                            .imgcondo.value =
                                                        value['imgcondo'];
                                                    loginController.nome.value =
                                                        value['nome'];
                                                    loginController.condoTheme
                                                        .value = value['cor'];

                                                    loginController.storageId();

                                                    themeController.setTheme(
                                                      loginController
                                                          .condoTheme.value,
                                                    );
                                                    Get.offNamed('/home');
                                                  }
                                                },
                                              );
                                            }
                                          },
                                        );
                                      }
                                    } else {
                                      onAlertButtonPressed(
                                          context,
                                          'Você precisa aceitar os termos de uso e a política de privacidade para entrar!',
                                          null);
                                    }
                                  },
                                  child: loginController.isLoading.value
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        )
                                      : Text(
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              child: ButtonTheme(
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .accentColor
                                          .withOpacity(.5),
                                    ),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                  ),
                                  onPressed: () {
                                    Get.toNamed('/esqueci');
                                  },
                                  child: Text(
                                    "Esqueceu a Senha?",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.amber, fontSize: 12),
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
            );
          },
        ),
      ),
    );
  }
}
