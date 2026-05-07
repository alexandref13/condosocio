import 'package:condosocio/src/components/visualizar_acessos/modal_bottom_sheet.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller_espera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../controllers/esperaacessos/visualizar_acessos_espera_controller.dart';

String _groupLabel(String datahora) {
  if (datahora.isEmpty) return '';
  return datahora.split(' ')[0];
}

String _hourLabel(String datahora) {
  final parts = datahora.split(' ');
  return parts.length > 1 ? parts[1] : '';
}

String _imageUrl(String imgfacial, String tipopessoa) {
  if (imgfacial.trim().isEmpty) return '';
  final isMorador = [
    'Morador',
    'Prestador',
    'Inquilino',
    'NM',
    'Prestador de Serviço',
    'Administrador',
    'Sindico',
    'Master',
  ].contains(tipopessoa);
  final folder = isMorador ? 'fotosperfil' : 'fotosvisitantes';
  return 'https://www.condosocio.com.br/acond/downloads/$folder/$imgfacial';
}

IconData _personTypeIcon(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized == 'convidado') {
    return Icons.person_add_alt_1_outlined;
  }

  if (normalized == 'prestador' || normalized == 'prestador de serviço') {
    return Icons.engineering_outlined;
  }

  if (normalized == 'appmobil' ||
      normalized == 'app mobilidade' ||
      normalized == 'app de mobilidade') {
    return Icons.local_taxi_outlined;
  }

  return Icons.person;
}

String _actorBadgeLabel(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized.contains('convidado')) return 'Convidado';
  if (normalized.contains('prestador')) return 'Prestador';
  if (normalized == 'appmobil' ||
      normalized.contains('app mobilidade') ||
      normalized.contains('app de mobilidade')) {
    return 'App Mobilidade';
  }
  if ([
    'morador',
    'inquilino',
    'administrador',
    'sindico',
    'síndico',
    'master',
    'nm',
  ].any((item) => normalized.contains(item))) {
    return 'Morador';
  }

  return tipopessoa.trim().isEmpty ? 'Acesso' : tipopessoa;
}

Color _actorBadgeColor(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized.contains('convidado')) return const Color(0xFF8BD3FF);
  if (normalized.contains('prestador')) return const Color(0xFFFFC978);
  if (normalized == 'appmobil' ||
      normalized.contains('app mobilidade') ||
      normalized.contains('app de mobilidade')) {
    return const Color(0xFFD2A8FF);
  }
  if ([
    'morador',
    'inquilino',
    'administrador',
    'sindico',
    'síndico',
    'master',
    'nm',
  ].any((item) => normalized.contains(item))) {
    return const Color(0xFF7EE787);
  }

  return const Color(0xFFD1D5DB);
}

IconData _actorBadgeIcon(String tipopessoa) {
  final normalized = tipopessoa.trim().toLowerCase();

  if (normalized.contains('convidado')) return Icons.person_add_alt_1_rounded;
  if (normalized.contains('prestador')) return Icons.engineering_rounded;
  if (normalized == 'appmobil' ||
      normalized.contains('app mobilidade') ||
      normalized.contains('app de mobilidade')) {
    return Icons.local_taxi_rounded;
  }
  if ([
    'morador',
    'inquilino',
    'administrador',
    'sindico',
    'síndico',
    'master',
    'nm',
  ].any((item) => normalized.contains(item))) {
    return Icons.home_rounded;
  }

  return Icons.person_rounded;
}

Widget listaVisualizarAcessosEspera() => const _ListaAcessosEspera();

class _ListaAcessosEspera extends StatefulWidget {
  const _ListaAcessosEspera();

  @override
  State<_ListaAcessosEspera> createState() => _ListaAcessosEsperaState();
}

class _ListaAcessosEsperaState extends State<_ListaAcessosEspera> {
  late VisualizarAcessosEsperaController _ctrl;
  late AcessosEsperaController _acessosCtrl;
  final List<Worker> _workers = [];

  @override
  void initState() {
    super.initState();
    _ctrl = Get.put(VisualizarAcessosEsperaController());
    _acessosCtrl = Get.put(AcessosEsperaController());
    _workers.add(ever(_ctrl.acessos, (_) {
      if (mounted) setState(() {});
    }));
    _workers.add(ever(_ctrl.searchResult, (_) {
      if (mounted) setState(() {});
    }));
    _workers.add(ever(_ctrl.isLoading, (_) {
      if (mounted) setState(() {});
    }));
  }

  @override
  void dispose() {
    for (final worker in _workers) {
      worker.dispose();
    }
    super.dispose();
  }

  List<dynamic> _buildItems(List list) {
    final List<dynamic> items = [];
    String lastGroup = '';

    for (final acesso in list) {
      final group = _groupLabel(acesso.datahora);
      if (group != lastGroup) {
        items.add(group);
        lastGroup = group;
      }
      items.add(acesso);
    }

    return items;
  }

  String _statusText(dynamic acesso) {
    if (acesso.dataent.trim().isEmpty) {
      return 'AGUARDANDO';
    }

    if (acesso.ctlreg == '2' || acesso.ctlreg == '3') {
      return 'SAIDA ${acesso.portao}'.trim();
    }

    return 'ENTRADA ${acesso.portao}'.trim();
  }

  String _detailText(dynamic acesso) {
    if (acesso.dataent.trim().isEmpty) {
      return '';
    }

    if ((acesso.ctlfacial == '0' || acesso.ctlreg == '2') &&
        acesso.dataent.trim().isNotEmpty) {
      return 'PORTARIA';
    }

    return acesso.portao.trim().isEmpty ? 'ACESSO' : acesso.portao;
  }

  String _displayHour(dynamic acesso) {
    if (acesso.dataent.trim().isEmpty) {
      return _hourLabel(acesso.datahora);
    }

    if (acesso.ctlreg == '2' || acesso.ctlreg == '3') {
      return _hourLabel(acesso.datasai);
    }

    return _hourLabel(acesso.dataent);
  }

  String _inviteAccessText(dynamic acesso) {
    if (acesso.acesso == '1') {
      return 'Acesso Livre';
    }

    if (acesso.acesso == '0') {
      return 'Único Acesso';
    }

    return '';
  }

  Color _inviteAccessColor(BuildContext context, dynamic acesso) {
    if (acesso.acesso == '1') {
      return const Color(0xFF87E8A3);
    }

    return Theme.of(context).colorScheme.secondaryContainer;
  }

  IconData _originIcon(dynamic acesso) {
    if ((acesso.ctlfacial == '0' || acesso.ctlreg == '2') &&
        acesso.dataent.trim().isNotEmpty) {
      return Icons.verified_user_outlined;
    }

    if (acesso.ctlfacial == '1') {
      return Icons.face_5_sharp;
    }

    return Icons.security;
  }

  IconData _movementIcon(dynamic acesso) {
    return acesso.acessotipo == 'VEICULO'
        ? Icons.directions_car_outlined
        : Icons.directions_walk;
  }

  IconData _statusIcon(dynamic acesso) {
    if (acesso.dataent.trim().isEmpty) {
      return Icons.hourglass_top_outlined;
    }

    if (acesso.ctlreg == '2' || acesso.ctlreg == '3') {
      return Icons.logout_outlined;
    }

    return Icons.login_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final list =
        (_ctrl.searchResult.isNotEmpty || _ctrl.search.value.text.isNotEmpty)
            ? _ctrl.searchResult.toList()
            : _ctrl.acessos.toList();

    final items = _buildItems(list);
    final textColor = Theme.of(context).textSelectionTheme.selectionColor!;

    return SmartRefresher(
      controller: _ctrl.refreshController,
      onRefresh: _ctrl.onRefresh,
      onLoading: _ctrl.onLoading,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          if (item is String) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
              child: Text(
                item,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: textColor.withValues(alpha: 0.6),
                ),
              ),
            );
          }

          final acesso = item;
          final previewUrl = _imageUrl(acesso.imgfacial, acesso.tipopessoa);
          final leadingIcon = _personTypeIcon(acesso.tipopessoa);
          final statusText = _statusText(acesso);
          final detailText = _detailText(acesso);
          final displayHour = _displayHour(acesso);
          final inviteAccessText = _inviteAccessText(acesso);

          return GestureDetector(
            onTap: () {
              _acessosCtrl.idAce.value = acesso.idace;
              _acessosCtrl.idfav.value = acesso.idfav;
              _acessosCtrl.tel.value = acesso.datasai;
              _acessosCtrl.idvis.value = acesso.idvis;

              configurandoModalBottomSheet(
                context,
                acesso.pessoa,
                acesso.placa,
                acesso.tipodoc,
                acesso.documento,
                acesso.idfav,
                acesso.dataent,
                acesso.cel,
                acesso.tipopessoa,
                acesso.idconv,
                acesso.imgfacial,
                acesso.idvis,
                '0',
                '',
                datasai: acesso.datasai,
                portao: acesso.portao,
                acessotipo: acesso.acessotipo,
                ctlfacial: acesso.ctlfacial,
                imgplaca: acesso.imgplaca,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: previewUrl.isEmpty
                            ? Container(
                                color: Theme.of(context).primaryColorDark,
                                alignment: Alignment.center,
                                child: Icon(
                                  leadingIcon,
                                  size: 28,
                                  color: textColor,
                                ),
                              )
                            : Image.network(
                                previewUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: Theme.of(context).primaryColorDark,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    leadingIcon,
                                    size: 28,
                                    color: textColor,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            acesso.pessoa,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _actorBadgeColor(acesso.tipopessoa)
                                  .withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: _actorBadgeColor(acesso.tipopessoa)
                                    .withValues(alpha: 0.45),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _actorBadgeIcon(acesso.tipopessoa),
                                  size: 12,
                                  color: _actorBadgeColor(acesso.tipopessoa),
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    _actorBadgeLabel(acesso.tipopessoa),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: _actorBadgeColor(acesso.tipopessoa),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            displayHour,
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: textColor.withValues(alpha: 0.62),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _statusIcon(acesso),
                              size: 20,
                              color: acesso.dataent.trim().isEmpty
                                  ? const Color(0xFFE9C46A)
                                  : acesso.ctlreg == '2' || acesso.ctlreg == '3'
                                      ? Theme.of(context).colorScheme.error
                                      : const Color(0xFF87E8A3),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: textColor.withValues(alpha: 0.72),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          statusText,
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: acesso.dataent.trim().isEmpty
                                ? const Color(0xFFE9C46A)
                                : acesso.ctlreg == '2' || acesso.ctlreg == '3'
                                    ? Theme.of(context).colorScheme.error
                                    : const Color(0xFF87E8A3),
                          ),
                        ),
                        if (inviteAccessText.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            inviteAccessText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _inviteAccessColor(context, acesso),
                            ),
                          ),
                        ],
                        if (detailText.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          Text(
                            detailText,
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              color: textColor.withValues(alpha: 0.62),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
