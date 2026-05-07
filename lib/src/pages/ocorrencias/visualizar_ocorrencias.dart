import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:condosocio/src/services/ocorrencias/map_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOcorrencias extends StatefulWidget {
  @override
  _VisualizarOcorrenciasState createState() => _VisualizarOcorrenciasState();
}

class _VisualizarOcorrenciasState extends State<VisualizarOcorrencias> {
  final VisualizarOcorrenciasController controller =
      Get.put(VisualizarOcorrenciasController());

  List<MapaOcorrencias> _visiveis() {
    if (controller.searchQuery.value.isNotEmpty) {
      return controller.searchResult.toList();
    }
    return controller.ocorrencias.toList();
  }

  String _ano(MapaOcorrencias o) {
    final partes = o.dataCompleta.split('/');
    return partes.length == 3 ? partes[2] : '';
  }

  List<Widget> _buildAgrupados(List<MapaOcorrencias> lista) {
    final widgets = <Widget>[];
    String? anoAtual;
    for (final o in lista) {
      final ano = _ano(o);
      if (ano.isNotEmpty && ano != anoAtual) {
        widgets.add(_YearHeader(ano: ano));
        anoAtual = ano;
      }
      widgets.add(_OcorrenciaCard(
        ocorrencia: o,
        onTap: () => _abrirDetalhe(o),
      ));
    }
    return widgets;
  }

  void _abrirDetalhe(MapaOcorrencias o) {
    controller.idoco.value = o.id;
    controller.data.value = o.data;
    controller.tipo.value = o.tipoco;
    controller.hour.value = o.hora;
    controller.dataoco.value = o.dataoco;
    controller.houroco.value = o.horaoco;
    controller.titulo.value = o.titulo;
    controller.status.value = o.status;
    controller.descricao.value = o.desc;
    controller.imagem.value = o.imgoco;
    Get.toNamed('/respostaOcorrencia');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicatorWidget();
      }

      final ocorrencias = _visiveis();
      final hasSearch = controller.searchQuery.value.isNotEmpty;

      return Column(
        children: [
          const SizedBox(height: 12),
          boxSearch(
            context,
            controller.search.value,
            controller.onSearchTextChanged,
            'Pesquise por Título...',
          ),
          Expanded(
            child: ocorrencias.isEmpty
                ? _EmptyState(hasSearch: hasSearch)
                : SmartRefresher(
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: !hasSearch && controller.hasMore.value,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    footer: ClassicFooter(
                      loadingText: 'Carregando mais ocorrências...',
                      idleText: 'Puxe para carregar mais',
                      noDataText: 'Todas as ocorrências foram carregadas',
                    ),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      children: _buildAgrupados(ocorrencias),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}

class _OcorrenciaCard extends StatelessWidget {
  final MapaOcorrencias ocorrencia;
  final VoidCallback onTap;

  const _OcorrenciaCard({required this.ocorrencia, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final isResolved = ocorrencia.status != '0';

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
                    ocorrencia.dia,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    ocorrencia.mes.toUpperCase(),
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
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      ocorrencia.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isResolved
                          ? Colors.green.withValues(alpha: 0.2)
                          : Colors.orange.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isResolved
                            ? Colors.green.withValues(alpha: 0.5)
                            : Colors.orange.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Text(
                      isResolved ? 'Resolvida' : 'Aberta',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isResolved ? Colors.green : Colors.orange,
                      ),
                    ),
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
    final title =
        hasSearch ? 'Nenhuma ocorrência encontrada' : 'Nenhuma ocorrência cadastrada';
    final subtitle = hasSearch
        ? 'Tente buscar por outro título de ocorrência.'
        : 'Quando houver ocorrências registradas, elas aparecerão aqui.';

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
