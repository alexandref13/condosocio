import 'package:condosocio/src/pages/ouvidoria/adiciona_ouvidoria.dart';
import 'package:condosocio/src/pages/ouvidoria/visualizar_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/controllers/ouvidoria/ouvidoria_controller.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Ouvidoria extends StatefulWidget {
  @override
  _OuvidoriaState createState() => _OuvidoriaState();
}

class _OuvidoriaState extends State<Ouvidoria> {
  OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());

  Widget _infoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 3, right: 8),
            child: Icon(Icons.check_circle_rounded,
                size: 16, color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                height: 1.45,
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Get.offNamed('/home'),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Text(
              'Ouvidoria',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Theme.of(context).textSelectionTheme.selectionColor!,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: Theme.of(context).textSelectionTheme.selectionColor!,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 24),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Sobre a Ouvidoria',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    icon: const Icon(Icons.close,
                                        color: Colors.white, size: 20),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              _infoItem('Envie sugestões, elogios, críticas ou pontos de atenção para a administração.'),
                              _infoItem('Descreva o assunto com clareza e inclua os detalhes mais relevantes.'),
                              _infoItem('Acompanhe as respostas e o andamento pelo próprio aplicativo.'),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  child: Text(
                                    'Fechar',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor:
                  Theme.of(context).textSelectionTheme.selectionColor!,
              indicatorPadding: const EdgeInsets.all(-4),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Theme.of(context)
                  .textSelectionTheme
                  .selectionColor!
                  .withValues(alpha: 0),
              tabs: [
                Text(
                  'Visualizar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
                Text(
                  'Adicionar',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).textSelectionTheme.selectionColor!,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CondoNavBar(),
          body: TabBarView(
            children: [VisualizarOuvidoria(), AdicionaOuvidoria()],
          ),
        ),
      ),
    );
  }
}
