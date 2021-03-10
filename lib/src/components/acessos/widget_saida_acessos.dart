import 'package:condosocio/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SaidaAcessos extends StatefulWidget {
  @override
  _SaidaAcessosState createState() => _SaidaAcessosState();
}

class _SaidaAcessosState extends State<SaidaAcessos> {
  TextEditingController name = new TextEditingController();
  TextEditingController observation = new TextEditingController();
  bool isLoading = false;
  var _tipos = [
    'Selecione',
    'Ocorrência',
    'Reclamação',
    'Solicitação',
    'Sugestão',
    'Elogio',
    'Outro'
  ];
  var _itemSelecionado = 'Selecione';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          customTextField(context, 'Nome Completo', null, false, 1, true, name),
          SizedBox(
            height: 10,
          ),
          customTextField(
              context, 'Observações', null, true, 5, true, observation),
          SizedBox(
            height: 30,
          ),
          ButtonTheme(
            height: 50.0,
            child: RaisedButton(
              elevation: 3,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                "ANEXAR IMAGEM",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
              ),
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonTheme(
            height: 50.0,
            child: RaisedButton(
              elevation: 3,
              onPressed: () {
                if (_itemSelecionado == 'Selecione') {
                  print('nao pode');
                }
                setState(() {
                  //isLoading = true;
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Text(
                      "AUTORIZAR",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 16),
                    ),
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonTheme(
            height: 50.0,
            child: RaisedButton(
              elevation: 3,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                "VISUALIZE SAÍDAS",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
              ),
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
