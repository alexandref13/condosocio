import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/visualizar_acessos/lista_visualizar_acessos.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessosEntrada extends StatelessWidget {
  const VisualizarAcessosEntrada({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarAcessosController acessosController =
        Get.put(VisualizarAcessosController());

    return Obx(
      () {
        return acessosController.isLoading.value
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
                        Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                  ),
                ),
              )
            : acessosController.acessos.length == 0
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
                      boxSearch(
                          context,
                          acessosController.search.value,
                          acessosController.onSearchTextChanged,
                          "Pesquise por Nome..."),
                      Container(
                        padding: EdgeInsets.all(20),
                        color: Theme.of(context).accentColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                'CRIADO',
                                style: GoogleFonts.montserrat(
                                    fontSize: 12.0,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2),
                              ),
                            ),
                            Center(
                                child: Text(
                              'NOME',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2),
                            )),
                            Center(
                                child: Text(
                              'ENTRADA',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2),
                            )),
                            Center(
                                child: Text(
                              'SAÍDA',
                              style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 2),
                            )),
                            Center(child: Text('')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: listaVisualizarAcessos(),
                      )
                    ],
                  );
      },
    );
  }
}
