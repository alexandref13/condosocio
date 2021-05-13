import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acessos/saida/visualizar_acessos_saida_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessosSaidas extends StatelessWidget {
  const VisualizarAcessosSaidas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarAcessosSaidaController saidaController =
        Get.put(VisualizarAcessosSaidaController());

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Saída',
        style: GoogleFonts.montserrat(
          fontSize: 16,
          color: Theme.of(context).textSelectionTheme.selectionColor,
        ),
      )),
      body: Obx(
        () {
          return saidaController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : saidaController.acessos.length == 0
                  ? Stack(
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
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sem registros de ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Acessos',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(
                      child: Column(
                        children: [
                          boxSearch(context, saidaController.search.value,
                              saidaController.onSearchTextChanged),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Theme.of(context).accentColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('NOME'),
                                Text('CRIADO'),
                                Text('SAÍDA'),
                                Container()
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: saidaController.acessos.length,
                                itemBuilder: (_, i) {
                                  var acessos = saidaController.acessos[i];
                                  return GestureDetector(
                                    onTap: () {
                                      saidaController.image.value =
                                          acessos.imgaut;
                                      saidaController.name.value = acessos.nome;
                                      saidaController.createDate.value =
                                          acessos.datacreate;
                                      saidaController.outDate.value =
                                          acessos.datasaida.toString();
                                      Get.toNamed('/detalhesAcessosSaida');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                            bottom: BorderSide(
                                                width: 2, color: Colors.grey),
                                          )),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: Text(
                                                  acessos.nome,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              acessos.datacreate == ''
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Icon(
                                                        FontAwesome.clock_o,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                                    )
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            acessos.datacreate,
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              acessos.datasaida.toString() ==
                                                      '0'
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Icon(
                                                        FontAwesome.clock_o,
                                                        size: 24,
                                                        color: Theme.of(context)
                                                            .textSelectionTheme
                                                            .selectionColor,
                                                      ),
                                                    )
                                                  : Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            acessos.datasaida
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 12,
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              Container(
                                                child: Icon(Icons.arrow_right),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    );
        },
      ),
    );
  }
}
