import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/senha_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Senha extends StatefulWidget {
  @override
  _SenhaState createState() => _SenhaState();
}

class _SenhaState extends State<Senha> {
  SenhaController senhaController = Get.put(SenhaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alterar Senha',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return senhaController.isLoading.value
                ? CircularProgressIndicatorWidget()
                : Container(
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: Form(
                        key: senhaController.form,
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
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Container(
                                //color: Color(0xfff5f5f5),
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
                                    labelText: 'Entre com a nova senha',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.red[900]!)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: Colors.white),
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty) return 'Campo Vazio!';
                                    return null;
                                  },
                                  controller: senhaController.senhanova.value,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                              child: Container(
                                //color: Color(0xfff5f5f5),
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
                                    labelText: 'Confirme a nova senha',
                                    labelStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        fontSize: 14),
                                    errorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error)),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.red[900]!)),
                                    errorStyle: GoogleFonts.montserrat(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                    prefixIcon: Icon(Icons.lock_outline,
                                        color: Colors.white),
                                  ),
                                  validator: (val) {
                                    //if (val.isEmpty) return 'Campo Vazio!';
                                    if (val !=
                                        senhaController.senhanova.value.text)
                                      return 'Senhas Não Conferem!';
                                    return null;
                                  },
                                  controller:
                                      senhaController.senhaconfirma.value,
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
                                    if (senhaController.form.currentState!
                                        .validate()) {
                                      senhaController
                                          .senha(context)
                                          .then((value) {
                                        print('valor: $value');

                                        if (value == 1) {
                                          confirmedButtonPressed(
                                            context,
                                            "Senha alterada com sucesso!",
                                            '',
                                          );
                                        } else {
                                          onAlertButtonPressed(
                                              context,
                                              "Algo deu errado.\n Tente novamente mais tarde.",
                                              '/home',
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
