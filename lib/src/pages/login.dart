import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/controllers/auth_controller.dart';
import 'package:condosocio/src/controllers/home_page_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Login extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final AuthController authController = Get.put(AuthController());
  final ThemeController themeController = Get.put(ThemeController());
  final HomePageController homePageController = Get.put(HomePageController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF114CB0),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "images/bannertopo.png"), // Substitua pelo caminho da sua imagem de fundo
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
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
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 156, 83, 252),
                          Color.fromARGB(255, 116, 16, 247),
                          Color(0xFF114CB0), // Cor inicial #114CB0
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
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
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!)),
                                      labelText: 'Entre com o e-mail',
                                      labelStyle: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontSize: 14),
                                      errorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!)),
                                      focusedErrorBorder:
                                          new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 163, 7, 27))),
                                      errorStyle: GoogleFonts.montserrat(
                                          color:
                                              Color.fromARGB(255, 163, 7, 27))),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (valueEmail) {
                                    if (!EmailValidator.validate(valueEmail!)) {
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
                                      labelText: 'Entre com a senha',
                                      labelStyle: GoogleFonts.montserrat(
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          fontSize: 14),
                                      errorBorder: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!)),
                                      focusedErrorBorder:
                                          new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 163, 7, 27))),
                                      errorStyle: GoogleFonts.montserrat(
                                          color:
                                              Color.fromARGB(255, 163, 7, 27))),
                                  validator: (valueSenha) {
                                    if (valueSenha!.isEmpty) {
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
                                        fillColor:
                                            MaterialStateColor.resolveWith(
                                                (states) {
                                          if (states.contains(
                                              MaterialState.selected)) {
                                            return Colors
                                                .black; // Define a cor do quadrado quando selecionado
                                          }
                                          return Colors
                                              .white; // Define a cor do quadrado quando não selecionado
                                        }),
                                        value: loginController.isChecked.value,
                                        onChanged: (bool? value) {
                                          loginController.isChecked.value =
                                              value!;
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Text.rich(TextSpan(
                                              text: 'Li e concordo com os ',
                                              style: GoogleFonts.montserrat(
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
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
                                                            'https://www.condosocio.com.br/termo.html',
                                                          );
                                                        },
                                                ),
                                                TextSpan(
                                                  text: 'e com a ',
                                                  style: GoogleFonts.montserrat(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor!,
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
                                                            'https://www.condosocio.com.br/privacidade.html',
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
                                        return Color.fromARGB(199, 14, 17, 196);
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
                                            '',
                                            'images/error.png');
                                      }
                                      if (_formKey.currentState!.validate()) {
                                        loginController.login().then(
                                          (value) {
                                            if (value == null) {
                                              loginController
                                                  .password.value.text = '';
                                              loginController.isLoading.value =
                                                  false;
                                              onAlertButtonPressed(
                                                  context,
                                                  'E-mail ou Senha Inválidos! \n Tente Novamente',
                                                  '',
                                                  'images/error.png');
                                            } else {
                                              loginController
                                                  .password.value.text = '';
                                              loginController.isLoading.value =
                                                  false;
                                              loginController
                                                  .hasMoreEmail(
                                                loginController
                                                    .email.value.text,
                                              )
                                                  .then(
                                                (response) {
                                                  print(
                                                      'Emails numeros ${response.length}');
                                                  if (response.length > 1 ||
                                                      loginController
                                                              .idcond.value ==
                                                          '') {
                                                    loginController
                                                        .haveListOfCondo
                                                        .value = true;

                                                    Get.toNamed('/listOfCondo');
                                                  } else {
                                                    loginController
                                                        .haveListOfCondo
                                                        .value = false;
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
                                                    loginController
                                                            .sobrenome.value =
                                                        value['sobrenome'];
                                                    loginController.condoTheme
                                                        .value = value['cor'];
                                                    loginController
                                                            .logradouro.value =
                                                        value['logradouro'];
                                                    loginController
                                                            .tipoun.value =
                                                        value['tipoun'];
                                                    loginController.dep.value =
                                                        value['dep'];
                                                    loginController
                                                            .condofacial.value =
                                                        value['condofacial'];
                                                    loginController
                                                            .imgfacial.value =
                                                        value['imgfacial'];
                                                    loginController.idadm
                                                        .value = value['idadm'];

                                                    loginController
                                                            .websiteAdministradora
                                                            .value =
                                                        value[
                                                            'website_administradora'];
                                                    loginController
                                                            .licenca.value =
                                                        value['licenca'];

                                                    loginController.storageId();

                                                    themeController.setTheme(
                                                      loginController
                                                          .condoTheme.value,
                                                    );

                                                    var sendTags = {
                                                      'idusu': loginController
                                                          .id.value,
                                                      'nome': loginController
                                                          .nome.value,
                                                      'sobrenome':
                                                          loginController
                                                              .idcond.value,
                                                    };

                                                    OneSignal.shared
                                                        .sendTags(sendTags)
                                                        .then((response) {
                                                      print(
                                                          "Successfully sent tags with response: $response");
                                                    }).catchError((error) {
                                                      print(
                                                          "Encountered an error sending tags: $error");
                                                    });

                                                    Get.toNamed('/home');
                                                  }
                                                },
                                              );
                                            }
                                          },
                                        );
                                      }
                                    } else {
                                      loginController.isLoading.value = false;
                                      onAlertButtonPressed(
                                          context,
                                          'Você precisa aceitar os termos de uso e a política de privacidade para entrar!',
                                          '',
                                          'images/error.png');
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
                                                  .selectionColor!,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          "Acessar",
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
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: ButtonTheme(
                                height: 50,
                                child: TextButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .colorScheme
                                          .secondary
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
                                    "Esqueci a senha",
                                    style: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        fontSize: 14),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: FaIcon(FontAwesomeIcons.globe),
                                          onPressed: () {
                                            // Link para Facebook
                                            homePageController.launched =
                                                homePageController.launchInBrowser(
                                                    'https://www.condosocio.com.br');
                                          },
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                        IconButton(
                                          icon:
                                              FaIcon(FontAwesomeIcons.facebook),
                                          onPressed: () {
                                            // Link para Facebook
                                            homePageController.launched =
                                                homePageController.launchInBrowser(
                                                    'https://www.facebook.com/condosocio');
                                          },
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                        IconButton(
                                          icon:
                                              FaIcon(FontAwesomeIcons.youtube),
                                          onPressed: () {
                                            // Link para YouTube
                                            homePageController.launched =
                                                homePageController.launchInBrowser(
                                                    'https://www.youtube.com/channel/UCLPOsAW7jbawmz7nB3UeDvg');
                                          },
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                        IconButton(
                                          icon: FaIcon(
                                              FontAwesomeIcons.instagram),
                                          onPressed: () {
                                            // Link para Instagram
                                            homePageController.launched =
                                                homePageController.launchInBrowser(
                                                    'https://www.instagram.com/condosocioapp');
                                          },
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                        IconButton(
                                          icon:
                                              FaIcon(FontAwesomeIcons.whatsapp),
                                          onPressed: () {
                                            // Link para Facebook
                                            homePageController.launched =
                                                homePageController
                                                    .launchInBrowser(
                                              'https://api.whatsapp.com/send?phone=5591981220670',
                                            );
                                          },
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ],
                                    ),
                                  ],
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
