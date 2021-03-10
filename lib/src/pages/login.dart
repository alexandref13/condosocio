import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:ui';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController loginController = Get.put(LoginController());

  // final email = new TextEditingController();
  // final senha = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // bool isLoading = false;
  // bool isLoggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    loginController.auth();
    super.initState();
  }

  // Future<void> logina() async {
  // final response = await http
  //     .post(Uri.https("condosocio.com.br", '/flutter/login.php'), body: {
  //   "login": email.text,
  //   "senha": senha.text,
  // });

  // var dados = response.body.split(' ');

  // print(dados);

  // var dadosUsuario = json.decode(dados[1] + dados[2] + dados[3]);

  // print(dadosUsuario);

  // if (dadosUsuario['valida'] == 1) {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('idusu', dadosUsuario['idusu']);

  // prefs.setString('idusu', dadosUsuario['idusu'].toString());
  // prefs.setString('nome', dadosUsuario['nome'].toString());
  // prefs.setString('tipo', dadosUsuario['tipo'].toString());
  // prefs.setString('email', dadosUsuario['email'].toString());
  // prefs.setString('nome_condo', dadosUsuario['nome_condo'].toString());
  // prefs.setString('imgperfil', dadosUsuario['imgperfil'].toString());
  // prefs.setString('imgcondo', dadosUsuario['imgcondo'].toString());

  // setState(() {
  //   isLoggedIn = true;
  //   isLoading = false;
  // });

  // final String id = prefs.getString('idusu');
  // final String nome = prefs.getString('nome');
  // final String tipo = prefs.getString('tipo');
  // final String email = prefs.getString('email');
  // final String imgperfil = prefs.getString('imgperfil');
  // final String nomeCondo = prefs.getString('nome_condo');
  // final String imgcondo = prefs.getString('imgcondo');

  // print({id, nome, email, imgperfil, nomeCondo, tipo, imgcondo});

  // Navigator.of(context).pushAndRemoveUntil(
  //     MaterialPageRoute(
  //       builder: (context) =>
  //           HomePage(id, nome, tipo, imgperfil, nomeCondo, imgcondo, email),
  //     ),
  //     (Route<dynamic> route) => false);
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     _onAlertButtonPressed(context);
  //   }
  // }

  var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    //descStyle: GoogleFonts.poppins(color: Colors.red,),
    animationDuration: Duration(milliseconds: 300),
    titleStyle: GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 18,
    ),
  );

  _onAlertButtonPressed(context) {
    Alert(
      image: Icon(
        Icons.highlight_off,
        color: Color(0xff1A936F),
        size: 60,
      ),
      style: alertStyle,
      context: context,
      title: "E-mail ou senha inválidos!\n Tente novamente.",
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          onPressed: () => Navigator.pop(context),
          width: 80,
          color: Color(0xff1A936F),
        )
      ],
    ).show();
  }

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
                              style: ButtonStyle(backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  return Theme.of(context).accentColor;
                                },
                              ), shape: MaterialStateProperty.resolveWith<
                                  OutlinedBorder>(
                                (Set<MaterialState> states) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  );
                                },
                              )),
                              onPressed: () {
                                loginController.login();
                                // if (_formKey.currentState.validate()) {
                                //   setState(() {
                                //     isLoading = true;
                                //   });

                                //   login();
                                // }
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

// RaisedButton(
//                               elevation: 3,
// onPressed: () {
//   if (_formKey.currentState.validate()) {
//     setState(() {
//       isLoading = true;
//     });
//     _login();
//   }
// },
// shape: new RoundedRectangleBorder(
//   borderRadius: new BorderRadius.circular(10.0),
// ),
// child: isLoading
//     ? SizedBox(
//         width: 20,
//         height: 20,
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation(
//               Colors.white),
//         ),
//       )
//     : Text(
//         "Entrar",
//         style: GoogleFonts.poppins(
//             color: Theme.of(context)
//                 .textSelectionTheme
//                 .selectionColor,
//             fontSize: 20),
//       ),
//                               color: Theme.of(context).accentColor,
//                             ),
