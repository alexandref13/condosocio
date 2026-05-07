import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:condosocio/src/services/ouvidoria/mapa_ouvidoria.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VisualizarOuvidoria extends StatefulWidget {
  @override
  _VisualizarOuvidoriaState createState() => _VisualizarOuvidoriaState();
}

class _VisualizarOuvidoriaState extends State<VisualizarOuvidoria> {
  final VisualizarOuvidoriaController controller =
      Get.put(VisualizarOuvidoriaController());

  List<MapaOuvidoria> _visiveis() {
    if (controller.searchQuery.value.isNotEmpty) {
      return controller.searchResult.toList();
    }
    return controller.ouvidoria.toList();
  }

  String _ano(MapaOuvidoria item) => item.ano.trim();

  List<Widget> _buildAgrupados(List<MapaOuvidoria> lista) {
    final widgets = <Widget>[];
    String? anoAtual;

    for (final item in lista) {
      final ano = _ano(item);
      if (ano.isNotEmpty && ano != anoAtual) {
        widgets.add(_YearHeader(ano: ano));
        anoAtual = ano;
      }

      widgets.add(
        _OuvidoriaCard(
          item: item,
          onTap: () => _abrirDetalhe(item),
        ),
      );
    }

    return widgets;
  }

  void _abrirDetalhe(MapaOuvidoria item) {
    controller.assunto.value = item.assunto;
    controller.message.value = item.msg;
    controller.data.value = item.data;
    controller.hora.value = item.hora;
    controller.id.value = item.idouv;
    Get.toNamed('/detalhesOuvidoria');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicatorWidget();
      }

      final itens = _visiveis();
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
            child: itens.isEmpty
                ? _EmptyState(hasSearch: hasSearch)
                : SmartRefresher(
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: controller.onRefresh,
                    onLoading: controller.onLoading,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      children: _buildAgrupados(itens),
                    ),
                  ),
          ),
        ],
      );
    });
  }
}

class _OuvidoriaCard extends StatelessWidget {
  final MapaOuvidoria item;
  final VoidCallback onTap;

  const _OuvidoriaCard({required this.item, required this.onTap});

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
                    item.dia,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    item.mes.toUpperCase(),
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
                      item.assunto,
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
                      color: Colors.blue.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Text(
                      'Ouvidoria',
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade200,
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
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset('images/semregistro.png', fit: BoxFit.fitWidth),
        ),
        Center(
          child: Text(
            hasSearch ? 'Nenhum registro encontrado' : 'Sem registros',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textSelectionTheme.selectionColor ??
                  Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
