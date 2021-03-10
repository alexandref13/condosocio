import 'package:condosocio/src/components/box_search.dart';
import 'package:condosocio/src/components/visualizar_acessos/lista_visualizar_acessos.dart';
import 'package:condosocio/src/controllers/visualizar_acessos_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
              : Column(
                  children: [
                    boxSearch(context, acessosController.search.value,
                        acessosController.onSearchTextChanged),
                    Container(
                      color: Theme.of(context).accentColor,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Data',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            'Nome',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            'Entrada',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            'Saída',
                            style: GoogleFonts.poppins(
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
