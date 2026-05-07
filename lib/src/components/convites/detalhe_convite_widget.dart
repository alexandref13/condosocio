import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

DateTime? _parseConviteDate(String value) {
  final normalized = value.trim();
  if (normalized.isEmpty) {
    return null;
  }

  final isoParsed = DateTime.tryParse(normalized);
  if (isoParsed != null) {
    return isoParsed;
  }

  final match = RegExp(
    r'^(\d{2})\/(\d{2})\/(\d{2,4})(?: (\d{2}):(\d{2})(?::(\d{2}))?)?$',
  ).firstMatch(normalized);

  if (match == null) {
    return null;
  }

  final day = int.tryParse(match.group(1) ?? '');
  final month = int.tryParse(match.group(2) ?? '');
  final rawYear = int.tryParse(match.group(3) ?? '');
  final hour = int.tryParse(match.group(4) ?? '') ?? 0;
  final minute = int.tryParse(match.group(5) ?? '') ?? 0;
  final second = int.tryParse(match.group(6) ?? '') ?? 0;

  if (day == null || month == null || rawYear == null) {
    return null;
  }

  final year = rawYear < 100 ? 2000 + rawYear : rawYear;
  return DateTime(year, month, day, hour, minute, second);
}

String _formatConviteDay(String value) {
  final date = _parseConviteDate(value);
  if (date == null) {
    final parts = value.trim().split(' ');
    return parts.isNotEmpty ? parts.first : '-';
  }
  return DateFormat('dd/MM/yy').format(date);
}

String _formatConviteHour(String value) {
  final date = _parseConviteDate(value);
  if (date == null) {
    final parts = value.trim().split(' ');
    if (parts.length > 1 && parts[1].trim().isNotEmpty) {
      return parts[1];
    }
    return '--:--';
  }
  return DateFormat('HH:mm').format(date);
}

String _guestImageUrl(Map convidado) {
  final imageName = (convidado['imgfacial'] ??
          convidado['imagem'] ??
          convidado['foto'] ??
          '')
      .toString()
      .trim();

  if (imageName.isEmpty) {
    return '';
  }

  final tipo = (convidado['tipo'] ?? '').toString();
  final isProfileFolder = [
    'Morador',
    'Prestador',
    'Inquilino',
    'NM',
    'Prestador de Serviço',
    'Administrador',
    'Sindico',
    'Master',
  ].contains(tipo);

  final folder = isProfileFolder ? 'fotosperfil' : 'fotosvisitantes';
  return 'https://www.condosocio.com.br/acond/downloads/$folder/$imageName';
}

IconData _guestLeadingIcon(Map convidado) {
  final tipo = (convidado['tipo'] ?? '').toString().trim().toLowerCase();
  final hasPlate =
      (convidado['placa'] ?? '').toString().trim().isNotEmpty;

  if (hasPlate) {
    return Icons.directions_car_outlined;
  }

  if (tipo == 'prestador' || tipo == 'prestador de serviço') {
    return Icons.engineering_outlined;
  }

  if (tipo == 'appmobil' ||
      tipo == 'app mobilidade' ||
      tipo == 'app de mobilidade') {
    return Icons.local_taxi_outlined;
  }

  return Icons.person_add_alt_1_outlined;
}

class DetalheConviteWidget extends StatelessWidget {
  const DetalheConviteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarConvitesController visualizarConvitesController =
        Get.find<VisualizarConvitesController>();
    ConvitesController convitesController = Get.find<ConvitesController>();
    LoginController loginController = Get.find<LoginController>();
    AcessosController acessosController = Get.find<AcessosController>();

    void voltarParaVisualizarConvites() {
      convitesController.page.value = 1;
      convitesController.selectedTabIndex.value = 1;

      if (Navigator.of(context).canPop()) {
        Get.back();
      } else {
        Get.offNamedUntil('/convites', (route) => false);
      }
    }

    Future<void> removeGuestFromInvite(List convidados, int index) async {
      final updatedGuests = convidados
          .asMap()
          .entries
          .where((entry) => entry.key != index)
          .map((entry) => Map<String, dynamic>.from(entry.value))
          .toList();

      convitesController.guestList.assignAll(updatedGuests);

      final value = await convitesController.editAInvite();
      final status = value is Map ? (value['status'] ?? 0) : value;

      if (status == 1) {
        convitesController.getConvites();
        convitesController.page.value = 1;
        convitesController.selectedTabIndex.value = 1;
        showToast(context, 'Parabéns!', 'Visitante excluído com sucesso.');
        voltarParaVisualizarConvites();
      } else if (status == 2) {
        onAlertButtonPressed(
          context,
          'Esse convidado já possui registro de entrada ou saída e não pode ser excluído.',
          '',
          'images/error.png',
        );
      } else {
        onAlertButtonPressed(
          context,
          'Algo deu errado!\nTente novamente',
          '',
          'images/error.png',
        );
      }
    }

    var date = DateTime.now();
    final endDate =
        _parseConviteDate(visualizarConvitesController.endDate.value);
    final formatEndDateDay =
        _formatConviteDay(visualizarConvitesController.endDate.value);
    final formatEndDateHour =
        _formatConviteHour(visualizarConvitesController.endDate.value);

    return WillPopScope(
      onWillPop: () async {
        voltarParaVisualizarConvites();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: voltarParaVisualizarConvites,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            visualizarConvitesController.titulo.value,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          ),
        ),
        body: Obx(() {
          return visualizarConvitesController.isLoading.value ||
                  acessosController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: ListView.builder(
                    itemCount: visualizarConvitesController.invite.length,
                    itemBuilder: (_, i) {
                      var invite = visualizarConvitesController.invite[i];

                      List convidados = invite['convidados'];

                      print("DADOS DETALHES CONVITES: $convidados");

                      for (var convidado in convidados) {
                        visualizarConvitesController.convidados.add(convidado);
                      }

                      var startDate = (invite['datainicial'] ?? '').toString();
                      visualizarConvitesController.startDate.value = startDate;
                      final formatStartDateDay =
                          _formatConviteDay(startDate);
                      final formatStartDateHour =
                          _formatConviteHour(startDate);

                      final isBefore =
                          endDate == null ? false : date.isBefore(endDate);

                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            child: Text(
                                              'Início',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                                size: 20,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  formatStartDateDay,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor!,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 30,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          size: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '${formatStartDateHour}h',
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    child: Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              'Término',
                                              style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor!,
                                                size: 20,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5),
                                                child: Text(
                                                  formatEndDateDay,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor!,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                          size: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '${formatEndDateHour}h',
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor!,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 50),
                              child: Row(
                                children: [
                                  Icon(
                                    visualizarConvitesController.acesso.value ==
                                                "1" ||
                                            convitesController
                                                    .isChecked.value ==
                                                true
                                        ? Icons.swap_horiz
                                        : Icons.arrow_right_alt,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor!,
                                    size: 26,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      visualizarConvitesController
                                                      .acesso.value ==
                                                  "1" ||
                                              convitesController
                                                      .isChecked.value ==
                                                  true
                                          ? "Acesso Livre"
                                          : "Único Acesso",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            for (var x = 0; x < convidados.length; x++)
                              Builder(
                                builder: (context) {
                                  final convidado = convidados[x];
                                  final textColor = Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!;
                                  final previewUrl = _guestImageUrl(convidado);
                                  final leadingIcon =
                                      _guestLeadingIcon(convidado);
                                  final secondaryInfo =
                                      convidado['tel'] != null &&
                                              convidado['tel']
                                                  .toString()
                                                  .trim()
                                                  .isNotEmpty
                                          ? convidado['tel'].toString()
                                          : (convidado['placa'] ?? '')
                                              .toString()
                                              .toUpperCase();
                                  final guestType =
                                      (convidado['tipo'] ?? 'Convidado')
                                          .toString();

                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          ClipOval(
                                            child: SizedBox(
                                              width: 52,
                                              height: 52,
                                              child: previewUrl.isEmpty
                                                  ? Container(
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(
                                                        leadingIcon,
                                                        size: 28,
                                                        color: textColor,
                                                      ),
                                                    )
                                                  : Image.network(
                                                      previewUrl,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (_, __, ___) =>
                                                              Container(
                                                        color: Theme.of(context)
                                                            .primaryColorDark,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          leadingIcon,
                                                          size: 28,
                                                          color: textColor,
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(width: 14),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  convidado['nome'] ?? '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.montserrat(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                    color: textColor,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  guestType,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      GoogleFonts.montserrat(
                                                    fontSize: 13,
                                                    color: textColor.withValues(
                                                        alpha: 0.82),
                                                  ),
                                                ),
                                                if (secondaryInfo
                                                    .trim()
                                                    .isNotEmpty) ...[
                                                  SizedBox(height: 6),
                                                  Text(
                                                    secondaryInfo,
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: GoogleFonts
                                                        .montserrat(
                                                      fontSize: 12,
                                                      color: textColor
                                                          .withValues(
                                                              alpha: 0.62),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          if (isBefore)
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    color: textColor,
                                                    size: 24,
                                                  ),
                                                  onPressed: () {
                                                    deleteAlert(
                                                      context,
                                                      'Deseja excluir este visitante?',
                                                      () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        removeGuestFromInvite(
                                                            convidados, x);
                                                      },
                                                    );
                                                  },
                                                ),
                                                if (convidado['tel'] != null)
                                                  InkWell(
                                                    child: Icon(
                                                      convidado['idfav'] ==
                                                                  null ||
                                                              convidado['idfav'] ==
                                                                  '' ||
                                                              convidado['idfav'] ==
                                                                  '0'
                                                          ? Icons.favorite_border
                                                          : Icons.favorite,
                                                      color: textColor,
                                                      size: 24,
                                                    ),
                                                    onTap: () {
                                                      acessosController
                                                              .idfav.value =
                                                          convidado['idfav'];
                                                      acessosController.tel
                                                              .value =
                                                          convidado['tel'];
                                                      acessosController
                                                              .name
                                                              .value
                                                              .text =
                                                          convidado['nome'];

                                                      acessosController
                                                          .sendFavoriteConvite()
                                                          .then((value) {
                                                        acessosController
                                                            .getFavoritos();
                                                        visualizarConvitesController
                                                            .getAConvite(
                                                          visualizarConvitesController
                                                              .idConv.value,
                                                        );
                                                      });
                                                    },
                                                  ),
                                                if (convidado['tel'] != null)
                                                  IconButton(
                                                    icon: Image.asset(
                                                      'images/whatsapp.png',
                                                      width: 34,
                                                      height: 34,
                                                    ),
                                                    onPressed: () {
                                                      visualizarConvitesController
                                                              .tel.value =
                                                          convidado['tel'];
                                                      visualizarConvitesController
                                                              .nameGuest.value =
                                                          convidado['nome'];

                                                      visualizarConvitesController
                                                          .verificaWhatsApp()
                                                          .then((res) {
                                                        final numero =
                                                            (res['numero'] ??
                                                                    '')
                                                                .toString();
                                                        final wame =
                                                            (res['wame'] ?? '')
                                                                .toString();
                                                        final valido =
                                                            res['valido'] ==
                                                                true;

                                                        visualizarConvitesController
                                                            .whatsappNumber
                                                            .value
                                                            .text = numero;

                                                        if (valido) {
                                                          visualizarConvitesController
                                                              .sendWhatsApp()
                                                              .then((value) {
                                                            if (value !=
                                                                    null &&
                                                                value['idace'] !=
                                                                    null &&
                                                                value['idace']
                                                                    .toString()
                                                                    .isNotEmpty) {
                                                              final message =
                                                                  'Olá! você foi convidado por ${loginController.nome.value} morador do condomínio ${loginController.nomeCondo.value}. '
                                                                  'Agilize seu acesso clicando no link e preencha os campos em abertos. Grato! '
                                                                  'https://www.condosocio.com.br/paginas/a.php?chave=${value['idace']}';
                                                              whatsAppSend(
                                                                context,
                                                                wame,
                                                                Uri.encodeFull(
                                                                  message,
                                                                ),
                                                              ).then((_) {
                                                                Get.offAllNamed(
                                                                    '/home');
                                                              });
                                                            } else {
                                                              onAlertButtonPressed(
                                                                context,
                                                                'Algo deu errado\nTente novamente',
                                                                '/home',
                                                                'images/error.png',
                                                              );
                                                            }
                                                          });
                                                        } else {
                                                          Get.toNamed(
                                                            '/whatsAppConvite',
                                                            arguments: numero,
                                                          );
                                                        }
                                                      });
                                                    },
                                                  ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            isBefore
                                ? Container(
                                    margin: EdgeInsets.symmetric(vertical: 40),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      border: Border(
                                        top: BorderSide(
                                          width: .5,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor!,
                                        ),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          ButtonTheme(
                                            height: 50.0,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .error;
                                                  },
                                                ),
                                                shape: MaterialStateProperty
                                                    .resolveWith<
                                                        OutlinedBorder>(
                                                  (Set<MaterialState> states) {
                                                    return RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    );
                                                  },
                                                ),
                                              ),
                                              onPressed: () {
                                                deleteAlert(context,
                                                    'Deseja deletar este convite?',
                                                    () {
                                                  Navigator.of(context).pop();
                                                  visualizarConvitesController
                                                      .deleteAConvite()
                                                      .then((value) {
                                                    if (value == 1) {
                                                      convitesController
                                                          .getConvites();
                                                      convitesController
                                                          .page.value = 1;
                                                      convitesController
                                                          .selectedTabIndex
                                                          .value = 1;
                                                      showToast(
                                                          context,
                                                          'Parabéns! Convite deletado com sucesso',
                                                          '');
                                                      Get.offNamedUntil(
                                                          '/convites',
                                                          (route) => false);
                                                    } else {
                                                      onAlertButtonPressed(
                                                          context,
                                                          'Algo deu errado!\n Tente novamente',
                                                          '/home',
                                                          '');
                                                    }
                                                  });
                                                });
                                              },
                                              child: Text(
                                                "Excluir Convite",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          ButtonTheme(
                                            height: 50.0,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                    return Theme.of(context)
                                                        .colorScheme
                                                        .secondary;
                                                  },
                                                ),
                                                shape: MaterialStateProperty
                                                    .resolveWith<
                                                        OutlinedBorder>(
                                                  (Set<MaterialState> states) {
                                                    return RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    );
                                                  },
                                                ),
                                              ),
                                              onPressed: () {
                                                convitesController
                                                    .isEdited.value = true;

                                                for (var i = 0;
                                                    i < convidados.length;
                                                    i++) {
                                                  convitesController.guestList
                                                      .addAll({
                                                    {
                                                      'nome':
                                                          visualizarConvitesController
                                                                  .convidados[i]
                                                              ['nome'],
                                                      'tel':
                                                          visualizarConvitesController
                                                                  .convidados[i]
                                                              ['tel'],
                                                      'tipo':
                                                          visualizarConvitesController
                                                                  .convidados[i]
                                                              ['tipo'],
                                                      'placa':
                                                          visualizarConvitesController
                                                                  .convidados[i]
                                                              ['placa'],
                                                    }
                                                  });
                                                }

                                                convitesController
                                                        .inviteName.value.text =
                                                    visualizarConvitesController
                                                        .titulo.value;
                                                convitesController
                                                        .startDate.value =
                                                    visualizarConvitesController
                                                        .startDate.value;
                                                convitesController
                                                        .endDate.value =
                                                    visualizarConvitesController
                                                        .endDate.value;

                                                convitesController.page.value =
                                                    2;

                                                print(
                                                    'GUESTLIST: ${convitesController.guestList}');
                                                Get.toNamed('/convites');
                                              },
                                              child: Text(
                                                "Editar",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  ),
                );
        }),
      ),
    );
  }
}
