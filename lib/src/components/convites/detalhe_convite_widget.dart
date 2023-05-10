import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:condosocio/src/components/utils/whatsapp_send.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DetalheConviteWidget extends StatelessWidget {
  const DetalheConviteWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());
    ConvitesController convitesController = Get.put(ConvitesController());
    LoginController loginController = Get.put(LoginController());
    VisualizarAcessosController visualizarAcessosController =
        Get.put(VisualizarAcessosController());
    AcessosController acessosController = Get.put(AcessosController());
    VisualizarConvitesController visualizarConviteController =
        Get.put(VisualizarConvitesController());

    var date = DateTime.now();
    var endDate = DateTime.parse(visualizarConvitesController.endDate.value);

    var formatEndDateDay = DateFormat("dd/MM/yy").format(
      endDate,
    );
    var formatEndDateHour = DateFormat("HH:mm").format(
      endDate,
    );

    return WillPopScope(
      onWillPop: () async {
        convitesController.page.value == 1;
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            visualizarConvitesController.titulo.value,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
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

                      print(convidados);

                      for (var convidado in convidados) {
                        visualizarConviteController.convidados.add(convidado);
                      }

                      var startDate = invite['datainicial'];
                      visualizarConvitesController.startDate.value = startDate;
                      var formatStartDate = startDate.split(' ');

                      var formatStartDateDay = formatStartDate[0];
                      var formatStartDateHour = formatStartDate[1];

                      var isBefore = date.isBefore(endDate);

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
                                                    .selectionColor,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Feather.calendar,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
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
                                                        .selectionColor,
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
                                              .selectionColor,
                                          size: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '${formatStartDateHour}h',
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
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
                                                    .selectionColor,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Feather.calendar,
                                                color: Theme.of(context)
                                                    .textSelectionTheme
                                                    .selectionColor,
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
                                                        .selectionColor,
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
                                              .selectionColor,
                                          size: 20,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            '${formatEndDateHour}h',
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
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
                                        .selectionColor,
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
                                            .selectionColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            for (var x = 0; x < convidados.length; x++)
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                    )),
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Icon(Feather.user_check),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .55,
                                                child: Text(
                                                  convidados[x]['nome'],
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .textSelectionTheme
                                                        .selectionColor,
                                                  ),
                                                ),
                                              ),
                                              convidados[x]['tel'] != null
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .55,
                                                      child: Text(
                                                        convidados[x]['tel'],
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 15,
                                                          color: Theme.of(
                                                                  context)
                                                              .textSelectionTheme
                                                              .selectionColor,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      child: convidados[x]
                                                                  ['placa'] !=
                                                              null
                                                          ? Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .55,
                                                              child: Text(
                                                                convidados[x][
                                                                        'placa']
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontSize: 15,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .textSelectionTheme
                                                                      .selectionColor,
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    isBefore
                                        ? Container(
                                            child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  convidados[x]['tel'] != null
                                                      ? InkWell(
                                                          child: Icon(
                                                            convidados[x]['idfav'] ==
                                                                        null ||
                                                                    convidados[x]
                                                                            [
                                                                            'idfav'] ==
                                                                        '0'
                                                                ? FontAwesome
                                                                    .heart_o
                                                                : FontAwesome
                                                                    .heart,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                          ),
                                                          onTap: () {
                                                            acessosController
                                                                    .idfav
                                                                    .value =
                                                                convidados[x]
                                                                    ['idfav'];
                                                            acessosController
                                                                    .tel.value =
                                                                convidados[x]
                                                                    ['tel'];
                                                            acessosController
                                                                    .name
                                                                    .value
                                                                    .text =
                                                                convidados[x]
                                                                    ['nome'];

                                                            acessosController
                                                                .sendFavoriteConvite()
                                                                .then((value) {
                                                              acessosController
                                                                  .getFavoritos();
                                                              visualizarConviteController
                                                                  .getAConvite(
                                                                      visualizarConviteController
                                                                          .idConv
                                                                          .value);
                                                              // Get.toNamed('/detalhesConvite');
                                                            });
                                                          },
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  convidados[x]['tel'] != null
                                                      ? IconButton(
                                                          icon: Icon(
                                                            FontAwesome
                                                                .whatsapp,
                                                            color: Theme.of(
                                                                    context)
                                                                .textSelectionTheme
                                                                .selectionColor,
                                                          ),
                                                          onPressed: () {
                                                            var celular;
                                                            visualizarConvitesController
                                                                    .tel.value =
                                                                convidados[x]
                                                                    ['tel'];
                                                            visualizarConvitesController
                                                                    .nameGuest
                                                                    .value =
                                                                convidados[x]
                                                                    ['nome'];

                                                            visualizarConvitesController
                                                                .verificaWhatsApp()
                                                                .then((value) {
                                                              value != 0
                                                                  ? celular = value[
                                                                      'celular']
                                                                  : convidados[x]['tel'] !=
                                                                          null
                                                                      ? celular = convidados[x][
                                                                              'tel']
                                                                          .replaceAll(
                                                                              "+",
                                                                              "")
                                                                          .replaceAll(
                                                                              "(",
                                                                              "")
                                                                          .replaceAll(
                                                                              ")",
                                                                              "")
                                                                          .replaceAll(
                                                                              "-",
                                                                              "")
                                                                          .replaceAll(
                                                                              " ",
                                                                              "")
                                                                      : celular =
                                                                          '';
                                                              visualizarConvitesController
                                                                  .whatsappNumber
                                                                  .value
                                                                  .text = celular;

                                                              if (celular
                                                                      .length ==
                                                                  11) {
                                                                visualizarConvitesController
                                                                    .sendWhatsApp()
                                                                    .then(
                                                                  (value) {
                                                                    if (value !=
                                                                        0) {
                                                                      String
                                                                          message =
                                                                          'Olá! você foi convidado pelo ${loginController.nome.value} morador do condomínio ${loginController.nomeCondo.value}. Agilize seu acesso clicando no link e preencha os campos em abertos. Grato! https://alvocomtec.com.br/paginas/a?chave=${value['idace']}';

                                                                      whatsAppSend(
                                                                        context,
                                                                        "55${visualizarConvitesController.whatsappNumber.value.text}",
                                                                        Uri.encodeFull(
                                                                          message,
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      onAlertButtonPressed(
                                                                          context,
                                                                          'Algo deu errado\n Tente novamente',
                                                                          '/home');
                                                                    }
                                                                  },
                                                                );
                                                              } else {
                                                                Get.toNamed(
                                                                    '/whatsAppConvite');
                                                              }
                                                            });
                                                          },
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ],
                                          ))
                                        : Container(),
                                  ],
                                ),
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
                                              .selectionColor,
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
                                                        .errorColor;
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
                                                  visualizarConvitesController
                                                      .deleteAConvite()
                                                      .then((value) {
                                                    if (value == 1) {
                                                      convitesController
                                                          .getConvites();
                                                      edgeAlertWidget(
                                                          context,
                                                          'Parabéns!',
                                                          'Convite deletado com sucesso.');
                                                      Get.offNamedUntil('home',
                                                          (route) => false);
                                                    } else {
                                                      onAlertButtonPressed(
                                                        context,
                                                        'Algo deu errado!\n Tente novamente',
                                                        '/home',
                                                      );
                                                    }
                                                  });
                                                });
                                              },
                                              child: Text(
                                                "Deletar",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
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
                                                convitesController.guestList
                                                    .clear();
                                                convitesController
                                                    .isEdited.value = true;
                                                for (var i = 0;
                                                    i <
                                                        visualizarConvitesController
                                                            .convidados.length;
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
                                                Get.toNamed('/convites');
                                              },
                                              child: Text(
                                                "Editar",
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
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
