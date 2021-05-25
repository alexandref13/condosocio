import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/edge_alert_error_widget.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
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
        title: Text('Alterar Senha'),
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
                                  keyboardType: TextInputType.emailAddress,
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: senhaController.email.value,
                                  validator: (val) {
                                    if (val.isEmpty) return 'Campo Vazio!';
                                    return null;
                                  },
                                  style: GoogleFonts.montserrat(
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                  ),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor)),
                                    labelText: 'Entre com o seu email',
                                    prefixIcon: Icon(Icons.mail_outline,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                    labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontSize: 16),
                                    errorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                        color: Theme.of(context).errorColor,
                                      ),
                                    ),
                                    focusedErrorBorder: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color:
                                                Theme.of(context).errorColor)),
                                    errorStyle: TextStyle(
                                        color: Theme.of(context).errorColor),
                                  ),
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
                                        return Color(0xff114B5F);
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
                                    if (senhaController.form.currentState
                                        .validate()) {
                                      senhaController
                                          .senha(context)
                                          .then((value) {
                                        if (value == 1) {
                                          edgeAlertWidget(context,
                                              'Email enviado com sucesso!');
                                        } else {
                                          edgeAlertErrorWidget(context,
                                              'Houve Algum Problema!\nTente novamente.');
                                        }
                                      });
                                    }
                                  },
                                  child: Text(
                                    "Enviar",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
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
