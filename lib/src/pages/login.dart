import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
                                  style: GoogleFonts.montserrat(
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor)),
                                    labelText: 'Entre com seu e-mail',
                                    prefixIcon: Icon(Icons.mail_outline,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                    labelStyle: GoogleFonts.montserrat(
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
                                  obscureText: true,
                                  style: GoogleFonts.montserrat(
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor)),
                                    labelText: 'Entre com a senha',
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                    labelStyle: GoogleFonts.montserrat(
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
                                      Container(
                                        child: Text.rich(TextSpan(
                                            text: '\nLi e concordo com os ',
                                            children: [
                                              TextSpan(
                                                text: 'TERMOS DE USO ',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.amberAccent,
                                                ),
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
                                              TextSpan(text: '\n\ne com a '),
                                              TextSpan(
                                                text:
                                                    'POLÍTICA DE PRIVACIDADE ',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.amberAccent,
                                                ),
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
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.white),
                                          ),
                                        )
                                      : Text(
                                          "Entrar",
                                          style: GoogleFonts.montserrat(
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
                                  onPressed: () {},
                                  child: Text(
                                    "Esqueceu a senha?",
                                    style: GoogleFonts.montserrat(
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
            );
          },
        ),
      ),
    );
  }
}
