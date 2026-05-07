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
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      final textColor =
                          Theme.of(context).textSelectionTheme.selectionColor!;
                      return Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.72,
                                  maxHeight: constraints.maxHeight * 0.48,
                                ),
                                child: Image.asset(
                                  'images/semregistro.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withValues(alpha: 0.42),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.10),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Nenhum acesso aguardando',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Quando houver visitantes aguardando entrada, eles aparecerão aqui.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        height: 1.45,
                                        color: textColor.withValues(alpha: 0.78),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
