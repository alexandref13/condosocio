import 'package:condosocio/src/components/utils/alert_button_pressed.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/confirmed_button_pressed.dart';
import 'package:condosocio/src/controllers/encomendas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetalhesEncomendas extends StatelessWidget {
  final EncomendasController encomendasController =
      Get.put(EncomendasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          encomendasController.codigo.value,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return encomendasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        'Data da chegada',
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
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            encomendasController.dataCriada
                                                .split(' ')[0],
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
                                      encomendasController.dataCriada
                                          .split(' ')[1],
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
                      encomendasController.dataEntrega.value != 'SEM REGISTRO'
                          ? Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                                              'Data da entrega',
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
                                                  encomendasController
                                                      .dataEntrega
                                                      .split(' ')[0],
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
                                            encomendasController.dataEntrega
                                                .split(' ')[1],
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
                            )
                          : Container(),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          'Informações',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          encomendasController.info.value,
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          'Status',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, bottom: 20),
                        child: Text(
                          encomendasController.status.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                      encomendasController.admEntrega.value != 'SEM REGISTRO'
                          ? Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                'Entrega na adminstração por',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            )
                          : Container(),
                      encomendasController.admEntrega.value != 'SEM REGISTRO'
                          ? Container(
                              margin: EdgeInsets.only(left: 20, bottom: 20),
                              child: Text(
                                encomendasController.admEntrega.value,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            )
                          : Container(),
                      encomendasController.dataEntrega.value == 'SEM REGISTRO'
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context).accentColor;
                                      },
                                    ),
                                    shape: MaterialStateProperty.resolveWith<
                                        OutlinedBorder>(
                                      (Set<MaterialState> states) {
                                        return RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        );
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    Alert(
                                      image: Icon(
                                        Icons.highlight_off,
                                        color: Colors.yellowAccent,
                                        size: 60,
                                      ),
                                      style: AlertStyle(
                                        backgroundColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        animationType: AnimationType.fromTop,
                                        isCloseButton: false,
                                        isOverlayTapDismiss: false,
                                        //descStyle: GoogleFonts.poppins(color: Colors.red,),
                                        animationDuration:
                                            Duration(milliseconds: 300),
                                        titleStyle: GoogleFonts.poppins(
                                          color: Theme.of(context).errorColor,
                                          fontSize: 18,
                                        ),
                                      ),
                                      context: context,
                                      title:
                                          'Confirma o recebimento da encomenda?',
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Cancelar",
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          width: 80,
                                          color: Theme.of(context).errorColor,
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "OK",
                                            style: GoogleFonts.montserrat(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontSize: 18,
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                            encomendasController
                                                .sendEncomendas()
                                                .then((value) {
                                              print('valor: $value');
                                              if (value == 1) {
                                                encomendasController
                                                    .getEncomendas();
                                                confirmedButtonPressed(
                                                  context,
                                                  'Encomenda recebida',
                                                  '/encomendas',
                                                );
                                              } else {
                                                onAlertButtonPressed(
                                                    context,
                                                    'Algo deu errado\n Tente novamente',
                                                    '/home');
                                              }
                                            });
                                          },
                                          width: 80,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      ],
                                    ).show();
                                  },
                                  child: Text(
                                    "RECEBER ENCOMENDA",
                                    style: GoogleFonts.montserrat(
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor,
                                      fontSize: 14,
                                    ),
                                  ),
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
  }
}
