import 'package:condosocio/src/components/visualizar_acessos/visualizar_acessos_entrada.dart';
import 'package:condosocio/src/pages/esperaacessos/acessos_espera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarAcessos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PopScope(
        canPop: false, // bloqueia o pop padrão; você controla abaixo
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) return; // se o sistema já consumiu o pop, não faça nada
          Get.offNamed('/home'); // sua navegação customizada ao voltar
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                onPressed: () => Get.toNamed('/convites'),
              ),
            ],
            title: Text(
              'Acessos',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor!,
              indicatorPadding: const EdgeInsets.all(-4),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Theme.of(context)
                  .textSelectionTheme
                  .selectionColor!
                  .withOpacity(0),
              tabs: [
                Text(
                  'Acessos',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
                Text(
                  'Aguardando',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              VisualizarAcessosEntrada(),
              AcessosEspera(),
            ],
          ),
        ),
      ),
    );
  }
}
