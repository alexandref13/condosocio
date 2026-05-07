import 'package:condosocio/src/components/utils/box_search.dart';
import 'package:condosocio/src/services/documentos/mapa_documentos.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentosCategoriaPage extends StatelessWidget {
  final String titulo;
  final RxBool isLoading;
  final TextEditingController searchController;
  final void Function(String) onSearchTextChanged;
  final List<MapaDocumentos> Function() itens;
  final void Function(MapaDocumentos) onOpen;

  const DocumentosCategoriaPage({
    super.key,
    required this.titulo,
    required this.isLoading,
    required this.searchController,
    required this.onSearchTextChanged,
    required this.itens,
    required this.onOpen,
  });

  String _day(String data) {
    final partes = data.split('/');
    return partes.isNotEmpty ? partes.first : '--';
  }

  String _month(String data) {
    final partes = data.split('/');
    return partes.length > 1 ? partes[1] : '--';
  }

  String _year(String data) {
    final partes = data.split('/');
    return partes.length > 2 ? partes[2] : '';
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titulo,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: textColor,
          ),
        ),
      ),
      body: Obx(() {
        if (isLoading.value) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).primaryColor,
            child: Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation(textColor),
                ),
              ),
            ),
          );
        }

        final docs = itens();
        final hasSearch = searchController.text.isNotEmpty;

        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              boxSearch(
                context,
                searchController,
                onSearchTextChanged,
                'Pesquise por Nome...',
              ),
              Expanded(
                child: docs.isEmpty
                    ? Center(
                        child: Text(
                          hasSearch
                              ? 'Nenhum documento encontrado'
                              : 'Nenhum documento disponível',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: textColor.withValues(alpha: 0.8),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          final doc = docs[index];
                          return _DocumentoCard(
                            nome: doc.nome,
                            descricao: doc.descricao,
                            data: doc.data,
                            day: _day(doc.data),
                            month: _month(doc.data),
                            year: _year(doc.data),
                            onTap: () => onOpen(doc),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _DocumentoCard extends StatelessWidget {
  final String nome;
  final String descricao;
  final String data;
  final String day;
  final String month;
  final String year;
  final VoidCallback onTap;

  const _DocumentoCard({
    required this.nome,
    required this.descricao,
    required this.data,
    required this.day,
    required this.month,
    required this.year,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textColor =
        Theme.of(context).textSelectionTheme.selectionColor ?? Colors.white;
    final subtitle = descricao.trim().isNotEmpty ? descricao.trim() : data;
    const downloadLabel = 'Toque para baixar';

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
                    day,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Text(
                    month,
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
                    nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontSize: 11,
                      color: textColor.withValues(alpha: 0.72),
                    ),
                  ),
                  if (year.isNotEmpty) ...[
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
                            downloadLabel,
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
