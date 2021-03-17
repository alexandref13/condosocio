import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/components/visualizar_acessos/lista_visualizar_acessos.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VisualizarAcessosController acessosController =
        Get.put(VisualizarAcessosController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visualizar acessos',
        ),
      ),
      body: Obx(
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
                            Theme.of(context).accentColor),
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
                  : Column(
                      children: [
                        boxSearch(context, acessosController.search.value,
                            acessosController.onSearchTextChanged),
                        Container(
                          color: Theme.of(context).accentColor,
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Data',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                              Text(
                                'Nome',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                              Text(
                                'Entrada',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                              Text(
                                'Saída',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: listaVisualizarAcessos(),
                        )
                      ],
                    );
        },
      ),
    );
  }
}
