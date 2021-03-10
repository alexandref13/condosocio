import 'package:condosocio/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EntradaAcessos extends StatefulWidget {
  @override
  _EntradaAcessosState createState() => _EntradaAcessosState();
}

class _EntradaAcessosState extends State<EntradaAcessos> {
  TextEditingController name = new TextEditingController();
  TextEditingController phone = new TextEditingController();

  String nomeCidade = '';
  bool isLoading = false;

  var _favoritos = [
    'Selecione o favorito',
    'Alexandre Fernandes',
    'Mãe',
  ];
  var _faloritosSelecionado = 'Selecione o favorito';

  var _tipos = [
    'Selecione o tipo de visitante',
    'Convidado',
    'Prestador',
    'App Mobilidade',
  ];
  var _itemSelecionado = 'Selecione o tipo de visitante';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 55,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  width: 1,
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 27,
                ),
                iconEnabledColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                dropdownColor: Theme.of(context).primaryColor,
                style: GoogleFonts.poppins(fontSize: 16),
                items: _favoritos.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  _dropDownFavoriteSelected(novoItemSelecionado);
                  setState(() {
                    this._faloritosSelecionado = novoItemSelecionado;
                  });
                },
                value: _faloritosSelecionado,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'OU',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            ButtonTheme(
              height: 50.0,
              child: RaisedButton(
                elevation: 3,
                onPressed: () {
                  if (_itemSelecionado == 'Selecione o tipo de visitante') {
                    print('nao pode');
                  }
                  setState(() {
                    isLoading = true;
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
                        "PROCURAR NOS SEUS CONTATOS",
                        style: GoogleFonts.poppins(
                            color: Theme.of(context).accentColor, fontSize: 16),
                      ),
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            SizedBox(
              height: 30,
            ),

            //NÃO CURTI MUITO COM O SEGUNDO "OU"

            // Text(
            //   'OU',
            //   style: GoogleFonts.poppins(
            //     fontSize: 20,
            //     color: Theme.of(context).textSelectionTheme.selectionColor,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Container(
              height: 55,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                  width: 1,
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 27,
                ),
                iconEnabledColor:
                    Theme.of(context).textSelectionTheme.selectionColor,
                dropdownColor: Theme.of(context).primaryColor,
                style: GoogleFonts.poppins(fontSize: 16),
                items: _tipos.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String novoItemSelecionado) {
                  _dropDownItemSelected(novoItemSelecionado);
                  setState(() {
                    this._itemSelecionado = novoItemSelecionado;
                  });
                },
                value: _itemSelecionado,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            customTextField(context, 'Entre com o nome ou empresa', null, false,
                1, true, name),
            SizedBox(
              height: 10,
            ),
            customTextField(
                context, 'Entre com o celular', null, false, 1, true, phone),
            SizedBox(
              height: 30,
            ),
            ButtonTheme(
              height: 50.0,
              child: RaisedButton(
                elevation: 3,
                onPressed: () {
                  if (_itemSelecionado == 'Selecione o tipo de visitante') {
                    print('nao pode');
                  }
                  setState(() {
                    isLoading = true;
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
                onPressed: () {
                  Navigator.pushNamed(context, '/visualizarAcessos');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Text(
                  "VISUALIZE ACESSOS",
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                ),
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      this._itemSelecionado = novoItem;
    });
  }

  void _dropDownFavoriteSelected(String novoItem) {
    setState(() {
      this._faloritosSelecionado = novoItem;
    });
  }
}
