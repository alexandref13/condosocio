import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';
import 'dart:async';
import 'dart:convert';

class Senha extends StatefulWidget {
  @override
  _SenhaState createState() => _SenhaState();
}

class _SenhaState extends State<Senha> {
  bool isLoading = false;

  final _form = GlobalKey<FormState>();

  TextEditingController senhaNova = new TextEditingController();
  TextEditingController senhaConfirma = new TextEditingController();

  Future<void> _alterarsenha() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String idusu = prefs.getString('idusu');

    final response = await http.post(
        Uri.https("http://www.focuseg.com.br", "/flutter/alterar_senha.php"),
        body: {
          "senha_nova": senhaNova.text,
          "idusu": idusu,
        });

    var dados = json.decode(response.body);

    if (dados['valida'] == 1) {
      setState(() {
        isLoading = false;
      });
      EdgeAlert.show(context,
          title: 'Email enviado com sucesso!',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.green,
          icon: Icons.check);
    } else {
      setState(() {
        isLoading = false;
      });
      EdgeAlert.show(context,
          title: 'Houve Algum Problema!\nTente novamente.',
          gravity: EdgeAlert.BOTTOM,
          backgroundColor: Colors.red,
          icon: Icons.highlight_off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Alterar Senha'),
        ),
        body: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicatorWidget()
              : Container(
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Form(
                      key: _form,
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
                                autovalidateMode: AutovalidateMode.always,
                                controller: senhaNova,
                                validator: (val) {
                                  if (val.isEmpty) return 'Campo Vazio!';
                                  return null;
                                },
                                obscureText: true,
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
                                      borderRadius: BorderRadius.circular(8.0),
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
                                          color: Theme.of(context).errorColor)),
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
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
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
                                  if (_form.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _alterarsenha();
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
                ),
        ));
  }
}
