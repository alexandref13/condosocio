import 'package:condosocio/src/components/alert_button_pressed.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController loginController = Get.put(LoginController());

  final LocalAuthentication localAuthentication = LocalAuthentication();
  bool canCheckBiometrics;
  List<BiometricType> availableBiometrics;
  String authorized = 'Not Authorized';
  bool isAuthenticating = false;

  @override
  void initState() {
    authenticate();
    super.initState();
  }

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await autoLogIn();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
  }

  Future<void> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');

    if (id != null) {
      bool isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (isAuthenticated) {
        loginController.isLoading.value = false;
        loginController.tipo.value = 'ADMIN';
        loginController.imgperfil.value = '';
        loginController.emailUsu.value = 'alefernandeseng@gmail.com';
        loginController.nomeCondo.value = "ALVO";
        loginController.imgcondo.value = '';
        loginController.nome.value = "Alexandre Fernandes";
        Get.toNamed('/home');
      } else {
        loginController.isLoading.value = false;
        return;
      }
    }
  }

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
                                        onAlertButtonPressed(context);
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
                        new Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          child: FlatButton(
                            textColor: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            splashColor: Theme.of(context).accentColor,
                            onPressed: () {
                              // if (_formKey.currentState.validate()) {
                              //   setState(() {
                              //     isLoading = true;
                              //   });
                              //   login();
                              // }
                            },
                            child: Text(
                              "Esqueceu a senha?",
                              style: GoogleFonts.poppins(fontSize: 12.0),
                              textDirection: TextDirection.ltr,
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
