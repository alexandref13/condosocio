import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/comunicados/visualizar_comunicados_controller.dart';
import 'package:condosocio/src/services/comunicados/mapa_comunicados.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Comunicados extends StatefulWidget {
  @override
  _ComunicadosState createState() => _ComunicadosState();
}

class _ComunicadosState extends State<Comunicados> {
  final VisualizarComunicadosController visualizarComunicadosController =
      Get.put(VisualizarComunicadosController());

  Future<void> _abrirArquivo(String url, String titulo) async {
    if (Platform.isAndroid) {
      // Android WebView não renderiza PDF nativamente — usa o Google Docs viewer
      final viewerUrl =
          'https://docs.google.com/gview?embedded=true&url=${Uri.encodeComponent(url)}';
      Get.toNamed('/webview', arguments: {'url': viewerUrl, 'titulo': titulo});
      return;
    }

    // iOS: SFSafariViewController renderiza PDF nativamente dentro do app
    final uri = Uri.parse(url);
    if (await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) return;
    if (await launchUrl(uri, mode: LaunchMode.externalApplication)) return;
  }

  List<DadosComunicados> _comunicadosVisiveis() {
    final bool hasSearch =
        visualizarComunicadosController.searchQuery.value.isNotEmpty;

    if (hasSearch) {
      return visualizarComunicadosController.searchResult.toList();
    }

    return visualizarComunicadosController.comunicados.toList();
  }

  String _anoDoComunicado(DadosComunicados comunicado) {
    final partes = comunicado.dataCompleta.split('/');
    if (partes.length == 3) {
      return partes[2];
    }
    return 'Sem data';
  }

  List<Widget> _buildComunicadosAgrupados(List<DadosComunicados> comunicados) {
    final widgets = <Widget>[];
    String? anoAtual;

    for (final comunicado in comunicados) {
      final ano = _anoDoComunicado(comunicado);

      if (ano != anoAtual) {
        widgets.add(_YearHeader(ano: ano));
        anoAtual = ano;
      }

      widgets.add(
        _ComunicadoCard(
          comunicado: comunicado,
          onTap: () {
            _abrirArquivo(
              'https://www.condosocio.com.br/acond/downloads/comunicados_arq/${comunicado.arquivo}',
              comunicado.titulo,
            );
          },
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offNamed('/home');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Comunicados',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: textColor,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: CondoNavBar(),
        body: Obx(() {
          final bool isLoading =
              visualizarComunicadosController.isLoading.value;
          final bool hasSearch =
              visualizarComunicadosController.searchQuery.value.isNotEmpty;
          final comunicados = _comunicadosVisiveis();

          if (isLoading && comunicados.isEmpty) {
            return CircularProgressIndicatorWidget();
          }

          return Column(
            children: [
              const SizedBox(height: 12),
              boxSearch(
                context,
                visualizarComunicadosController.search.value,
                visualizarComunicadosController.onSearchTextChanged,
                'Pesquise os Comunicados...',
              ),
              Expanded(
                child: comunicados.isEmpty
                    ? _EmptyState(hasSearch: hasSearch)
                    : SmartRefresher(
                        controller:
                            visualizarComunicadosController.refreshController,
                        enablePullDown: true,
                        enablePullUp: !hasSearch &&
                            visualizarComunicadosController.hasMore.value,
                        onRefresh: visualizarComunicadosController.onRefresh,
                        onLoading: visualizarComunicadosController.onLoading,
                        footer: ClassicFooter(
                          loadingText: 'Carregando mais comunicados...',
                          idleText: 'Puxe para carregar mais',
                          noDataText: 'Todos os comunicados foram carregados',
                        ),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                          children: _buildComunicadosAgrupados(comunicados),
                        ),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class _ComunicadoCard extends StatelessWidget {
  final DadosComunicados comunicado;
  final VoidCallback onTap;

  const _ComunicadoCard({
    required this.comunicado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color:
                    Theme.of(context).primaryColorDark.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Theme.of(context)
                      .primaryColorDark
                      .withValues(alpha: 0.45),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    comunicado.dia,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    comunicado.mes.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: textColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comunicado.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.file_download_outlined,
                        size: 16,
                        color: textColor.withValues(alpha: 0.75),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Toque para baixar o comunicado',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            color: textColor.withValues(alpha: 0.72),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: textColor.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

class _YearHeader extends StatelessWidget {
  final String ano;

  const _YearHeader({required this.ano});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Text(
            ano,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: textColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: textColor.withValues(alpha: 0.22),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool hasSearch;

  const _EmptyState({required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final title = hasSearch
        ? 'Nenhum comunicado encontrado'
        : 'Nenhum comunicado cadastrado';
    final subtitle = hasSearch
        ? 'Tente buscar por outro título de comunicado.'
        : 'Quando houver comunicados publicados pela administração, eles aparecerão aqui.';

    return LayoutBuilder(
      builder: (context, constraints) {
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
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
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
    );
  }
}
