import 'package:condosocio/src/components/dependentes/modal_bottom_sheet.dart';
import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/pages/veiculos/modal_veiculos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/veiculos/veiculos_controller.dart';

class VisualizarVeiculos extends StatefulWidget {
  @override
  _VisualizarVeiculosState createState() => _VisualizarVeiculosState();
}

class _VisualizarVeiculosState extends State<VisualizarVeiculos> {
  VeiculosController veiculosController = Get.put(VeiculosController());

  @override
  void initState() {
    veiculosController.getVeiculos();

    super.initState();
  }

  @override
  void dispose() {
    // Coloque aqui o código que precisa ser executado ao sair do widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VeiculosController veiculosController = Get.put(VeiculosController());

    return Obx(() {
      return veiculosController.isLoading.value
          ? CircularProgressIndicatorWidget()
          : veiculosController.veiculos.length == 0
              ? Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
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
                          Text(
                            'Sem registros',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20)),
                    /*boxSearch(context, veiculosController.search.value,
                        veiculosController.onSearchTextChanged, "Pesquise ..."),*/
                    Container(
                      padding: EdgeInsets.all(15),
                      color: Theme.of(context).accentColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'MARCA\nMODELO',
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'COR\nANO',
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 4),
                            child: Text(
                              'PLACA',
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 18),
                            child: Text(
                              'DESDE\n(VAGAS)',
                              style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemCount: veiculosController.veiculos.length,
                          itemBuilder: (_, i) {
                            var veiculos = veiculosController.veiculos[i];

                            // constroe as var int para condicao em adiciona veiculos
                            veiculosController.qtdVag.value =
                                int.parse(veiculos.qtdVagas);
                            veiculosController.cont.value =
                                int.parse(veiculos.contagem);

                            return GestureDetector(
                              onTap: () {
                                veiculosModalBottomSheet(
                                    context,
                                    veiculos.idvei,
                                    veiculos.marca,
                                    veiculos.modelo,
                                    veiculos.placa);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey),
                                    )),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          child: Text(
                                            '${veiculos.marca}\n${veiculos.modelo}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: Text(
                                            '${veiculos.cor}\n${veiculos.ano}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Text(
                                            veiculos.placa,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            '${veiculos.desde}\n(${veiculos.contagem}/${veiculos.qtdVagas})',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                          child: Icon(Icons.arrow_right),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
    });
  }
}
