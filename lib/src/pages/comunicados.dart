import 'dart:convert';
import 'package:condosocio/src/controllers/comunicados_controller.dart';
import 'package:flutter/material.dart';
import 'package:condosocio/src/pages/detalhes.dart';
import 'package:condosocio/src/services/comunicados/api_comunicados.dart';
import 'package:condosocio/src/services/comunicados/mapa_comunicados.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Comunicados extends StatefulWidget {
  @override
  _ComunicadosState createState() => _ComunicadosState();
}

class _ComunicadosState extends State<Comunicados> {
  ComunicadosController comunicadosController =
      Get.put(ComunicadosController());
  // List<DadosComunicados> comunicados =
  //     List<DadosComunicados>.empty(growable: true);
  // bool isLoading = true;

  // _getComunicados() {
  //   API_COMUN.getComunicados().then((response) {
  //     print(json.decode(response.body));
  //     setState(() {
  //       Iterable lista = json.decode(response.body);
  //       comunicados =
  //           lista.map((model) => DadosComunicados.fromJson(model)).toList();
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    comunicadosController.getComunicados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Comunicados', style: GoogleFonts.poppins(fontSize: 20)),
          centerTitle: true,
        ),
        body: Obx(
          () {
            return comunicadosController.isLoading.value
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  )
                : _listaComunicados();
          },
        ),
      ),
    );
  }

  _listaComunicados() {
    if (comunicadosController.comunicados.length == 0) {
      return Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black12,
            child: Image.asset(
              'images/semregistro.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                  ),
                  RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Sem registros de ',
                            style: GoogleFonts.poppins(fontSize: 16)),
                        TextSpan(
                            text: 'Comunicados',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  )
                ]),
          )
        ],
      );
    } else {
      return Container(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              Container(
                  padding: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: comunicadosController.comunicados.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Theme.of(context).accentColor,
                          child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Detalhes(
                                        comunicadosController
                                            .comunicados[index].titulo,
                                        comunicadosController
                                            .comunicados[index].texto,
                                        comunicadosController
                                            .comunicados[index].dia,
                                        comunicadosController
                                            .comunicados[index].mes,
                                        comunicadosController
                                            .comunicados[index].hora)));
                              },
                              leading: RichText(
                                text: TextSpan(
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: comunicadosController
                                                  .comunicados[index].dia +
                                              "  ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: comunicadosController
                                              .comunicados[index].mes,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              letterSpacing: 2)),
                                    ]),
                              ),
                              title: Padding(
                                padding: EdgeInsets.only(left: 30),
                                child: Text(
                                  comunicadosController
                                      .comunicados[index].titulo,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_right_alt_rounded,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                size: 30,
                              )),
                        );
                      }))
            ],
          ));
    }
  }
}
