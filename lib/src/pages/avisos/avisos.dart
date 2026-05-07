import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/avisos/visualizar_avisos_controller.dart';
import 'package:condosocio/src/services/avisos/mapa_avisos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Avisos extends StatefulWidget {
  @override
  _AvisosState createState() => _AvisosState();
}

class _AvisosState extends State<Avisos> {
  final VisualizarAvisosController visualizarAvisosController =
      Get.put(VisualizarAvisosController());

  @override
  void initState() {
    super.initState();
  }

  List<DadosAvisos> _avisosVisiveis() {
    if (visualizarAvisosController.searchQuery.value.isNotEmpty) {
      return visualizarAvisosController.searchResult.toList();
    }
    return visualizarAvisosController.avisos.toList();
  }

  String _anodoAviso(DadosAvisos aviso) {
    final partes = aviso.dataCompleta.split('/');
    return partes.length == 3 ? partes[2] : '';
  }

  List<Widget> _buildAvisosAgrupados(List<DadosAvisos> avisos) {
    final widgets = <Widget>[];
    String? anoAtual;
    for (final aviso in avisos) {
      final ano = _anodoAviso(aviso);
      if (ano.isNotEmpty && ano != anoAtual) {
        widgets.add(_YearHeader(ano: ano));
        anoAtual = ano;
      }
      widgets.add(_AvisoCard(
        aviso: aviso,
        onTap: () => _abrirDetalhe(aviso),
      ));
    }
    return widgets;
  }

  void _abrirDetalhe(DadosAvisos aviso) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final texto = aviso.texto.split('<table')[0];

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Text(
                'AVISO',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Html(
                  data: texto,
                  style: {
                    'p': Style(color: textColor, fontFamily: 'montserrat'),
                    'h1': Style(color: textColor),
                    'h2': Style(color: textColor),
                    'h3': Style(color: textColor),
                    'li': Style(color: textColor, display: Display.block),
                    'a': Style(
                        color: textColor, textDecoration: TextDecoration.none),
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .primaryColorDark
                        .withValues(alpha: 0.15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Fechar',
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.offNamed('/home'),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Avisos',
            style: GoogleFonts.montserrat(fontSize: 16, color: textColor),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: CondoNavBar(),
        body: Obx(() {
          if (visualizarAvisosController.isLoading.value) {
            return CircularProgressIndicatorWidget();
          }

          final avisos = _avisosVisiveis();
          final hasSearch =
              visualizarAvisosController.searchQuery.value.isNotEmpty;

          return Column(
            children: [
              const SizedBox(height: 12),
              boxSearch(
                context,
                visualizarAvisosController.search.value,
                visualizarAvisosController.onSearchTextChanged,
                'Pesquise os Avisos...',
              ),
              Expanded(
                child: avisos.isEmpty
                    ? _EmptyState(hasSearch: hasSearch)
                    : SmartRefresher(
                        controller:
                            visualizarAvisosController.refreshController,
                        enablePullDown: true,
                        enablePullUp: !hasSearch &&
                            visualizarAvisosController.hasMore.value,
                        onRefresh: visualizarAvisosController.onRefresh,
                        onLoading: visualizarAvisosController.onLoading,
                        footer: ClassicFooter(
                          loadingText: 'Carregando mais avisos...',
                          idleText: 'Puxe para carregar mais',
                          noDataText: 'Todos os avisos foram carregados',
                        ),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                          children: _buildAvisosAgrupados(avisos),
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

class _AvisoCard extends StatelessWidget {
  final DadosAvisos aviso;
  final VoidCallback onTap;

  const _AvisoCard({required this.aviso, required this.onTap});

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
                    aviso.dia,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    aviso.mes.toUpperCase(),
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
                    aviso.titulo,
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
                        Icons.access_time_outlined,
                        size: 14,
                        color: textColor.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        aviso.hora,
                        style: GoogleFonts.montserrat(
                          fontSize: 11,
                          color: textColor.withValues(alpha: 0.72),
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
    final title = hasSearch ? 'Nenhum aviso encontrado' : 'Nenhum aviso cadastrado';
    final subtitle = hasSearch
        ? 'Tente buscar por outro título de aviso.'
        : 'Quando houver avisos publicados pela administração, eles aparecerão aqui.';

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
