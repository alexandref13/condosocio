import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/pages/esperaacessos/lista_visualizar_acessos_espera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';

class AcessosEspera extends StatelessWidget {
  const AcessosEspera({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarAcessosEsperaController acessosEsperaController =
        Get.put(VisualizarAcessosEsperaController());

    return Obx(
      () {
        return acessosEsperaController.isLoading.value
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
                        Theme.of(context).textSelectionTheme.selectionColor!,
                      ),
                    ),
                  ),
                ),
              )
            : acessosEsperaController.acessos.length == 0
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
                                    .selectionColor!,
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
                      boxSearch(
                          context,
                          acessosEsperaController.search.value,
                          acessosEsperaController.onSearchTextChanged,
                          "Pesquise por Nome..."),
                      Expanded(
                        child: listaVisualizarAcessosEspera(),
                      )
                    ],
                  );
      },
    );
  }
}
