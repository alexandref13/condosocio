import 'package:condosocio/src/pages/ocorrencias/adicionar_ocorrencias.dart';
import 'package:condosocio/src/pages/ocorrencias/visualizar_ocorrencias.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Ocorrencias extends StatefulWidget {
  @override
  _OcorrenciasState createState() => _OcorrenciasState();
}

class _OcorrenciasState extends State<Ocorrencias> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.offNamed('/home'),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Ocorrências',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
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
                                    'Sobre as Ocorrências',
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
                            _infoItem('Registre problemas ou incidentes que precisem da atenção da administração.'),
                            _infoItem('Informe o que aconteceu com clareza e adicione uma foto sempre que possível.'),
                            _infoItem('Apenas a administração terá acesso ao conteúdo enviado.'),
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
          children: [VisualizarOcorrencias(), AdicionarOcorrencias()],
        ),
      ),
    );
  }
}
