import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';
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
          title: 'Senha Alterada Com Sucesso!',
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
          elevation: 0,
          title: Text('Alterar Senha'),
          centerTitle: true,
          backgroundColor: Color(0xff1A936F),
        ),
        body: SingleChildScrollView(
          child: isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black,
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(Colors.red[900]),
                      ),
                      height: 40,
                      width: 40,
                    ),
                  ),
                )
              : Container(
                  color: Colors.black,
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SFUIDisplay'),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: 'Entre com a nova senha',
                                  prefixIcon: Icon(Icons.mail_outline,
                                      color: Colors.white),
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  errorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff114B5F))),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff114B5F))),
                                  errorStyle:
                                      TextStyle(color: Color(0xff114B5F)),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                            child: Container(
                              //color: Color(0xfff5f5f5),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                controller: senhaConfirma,
                                validator: (val) {
                                  if (val.isEmpty) return 'Campo Vazio!';
                                  if (val != senhaNova.text)
                                    return 'Senhas Não Conferem!';
                                  return null;
                                },
                                obscureText: true,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'SFUIDisplay'),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  labelText: 'Confirme a nova senha',
                                  prefixIcon: Icon(Icons.mail_outline,
                                      color: Colors.white),
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  errorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff114B5F))),
                                  focusedErrorBorder: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Color(0xff114B5F))),
                                  errorStyle:
                                      TextStyle(color: Color(0xff114B5F)),
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
                                  "Alterar",
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
