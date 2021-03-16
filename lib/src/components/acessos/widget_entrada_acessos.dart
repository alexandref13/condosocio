import 'package:condosocio/src/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EntradaAcessos extends StatefulWidget {
  @override
  _EntradaAcessosState createState() => _EntradaAcessosState();
}

class _EntradaAcessosState extends State<EntradaAcessos> {
  TextEditingController nome = new TextEditingController();
  TextEditingController telefone = new TextEditingController();
  TextEditingController documento = new TextEditingController();
  TextEditingController placa = new TextEditingController();
  TextEditingController marca = new TextEditingController();

  String nomeCidade = '';
  bool isLoading = false;

  var _favoritos = [
    'Selecione o favorito',
    'Alexandre Fernandes',
    'Mãe',
  ];
  var _favoritosSelecionado = 'Selecione o favorito';

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
                    this._favoritosSelecionado = novoItemSelecionado;
                  });
                },
                value: _favoritosSelecionado,
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
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Theme.of(context)
                          .textSelectionTheme
                          .selectionColor;
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
              ),
            ),
            SizedBox(
              height: 30,
            ),
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
            customTextField(
                context, 'Nome ou empresa', null, false, 1, true, nome),
            SizedBox(
              height: 10,
            ),
            customTextField(context, 'Celular', null, false, 1, true, telefone),
            SizedBox(
              height: 10,
            ),
            customTextField(
                context, 'Documento', null, false, 1, true, documento),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            customTextField(
                context, 'Placa do veiculo', null, false, 1, true, placa),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            customTextField(
                context, 'Marca do veiculo', null, false, 1, true, marca),
            SizedBox(
              height: 30,
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
                onPressed: () {},
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
                      return Theme.of(context)
                          .textSelectionTheme
                          .selectionColor;
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
                  Get.toNamed('/visualizarAcessos');
                },
                child: Text(
                  "VISUALIZE ACESSOS",
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                ),
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
      this._favoritosSelecionado = novoItem;
    });
  }
}
