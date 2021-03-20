import 'package:condosocio/src/components/utils/custom_text_field.dart';
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
  // var _tipos = [
  //   'Selecione',
  //   'Ocorrência',
  //   'Reclamação',
  //   'Solicitação',
  //   'Sugestão',
  //   'Elogio',
  //   'Outro'
  // ];
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
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Theme.of(context).textSelectionTheme.selectionColor;
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    return 3;
                  },
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  },
                ),
              ),
              onPressed: () {},
              child: Text(
                "ANEXAR IMAGEM",
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonTheme(
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Theme.of(context).accentColor;
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    return 3;
                  },
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  },
                ),
              ),
              onPressed: () {
                if (_itemSelecionado == 'Selecione') {
                  print('nao pode');
                }
                setState(() {
                  //isLoading = true;
                });
              },
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
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 16),
                    ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ButtonTheme(
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Theme.of(context).textSelectionTheme.selectionColor;
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    return 3;
                  },
                ),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  },
                ),
              ),
              onPressed: () {},
              child: Text(
                "VISUALIZE SAÍDAS",
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 16),
              ),
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
