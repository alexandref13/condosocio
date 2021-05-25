import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/components/utils/progress_indicator_widget.dart';
import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:condosocio/src/controllers/enquetes/votar_enquete.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VotarEnquete extends StatelessWidget {
  final VotarEnqueteController enquetesController =
      Get.put(VotarEnqueteController());
  final VisualizarEnquetesController visualizarEnquetesController =
      Get.put(VisualizarEnquetesController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    confirmedVote(String text, VoidCallback function) {
      Alert(
        image: Icon(
          Icons.highlight_off,
          color: Colors.yellowAccent,
          size: 60,
        ),
        style: AlertStyle(
          backgroundColor: Theme.of(context).textSelectionTheme.selectionColor,
          animationType: AnimationType.fromTop,
          isCloseButton: false,
          isOverlayTapDismiss: false,
          //descStyle: GoogleFonts.poppins(color: Colors.red,),
          animationDuration: Duration(milliseconds: 300),
          titleStyle: GoogleFonts.poppins(
            color: Theme.of(context).errorColor,
            fontSize: 18,
          ),
        ),
        context: context,
        title: text,
        buttons: [
          DialogButton(
            child: Text(
              "Cancelar",
              style: GoogleFonts.montserrat(
                color: Theme.of(context).textSelectionTheme.selectionColor,
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
                color: Theme.of(context).textSelectionTheme.selectionColor,
                fontSize: 18,
              ),
            ),
            onPressed: function,
            width: 80,
            color: Theme.of(context).primaryColor,
          )
        ],
      ).show();
    }

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return enquetesController.isLoading.value
            ? CircularProgressIndicatorWidget()
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      enquetesController.enquete[0]['verificavoto'] !=
                              'Não Votou'
                          ? Container(
                              child: Center(
                                child: Text(
                                  loginController.nome.value,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(),
                      enquetesController.enquete[0]['verificavoto'] !=
                              'Não Votou'
                          ? Container(
                              child: Center(
                                child: Text(
                                  'Obrigado pela sua participação',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Center(
                            child: Text(
                          visualizarEnquetesController.titulo.value,
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                          ),
                        )),
                      ),
                      for (var i = 0;
                          i < enquetesController.enquete[0]['qdtperguntas'];
                          i++)
                        Container(
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).accentColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context).buttonColor,
                                      spreadRadius: 3,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    enquetesController.enquete[0]
                                                ['verificavoto'] ==
                                            'Não Votou'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                enquetesController.enquete[0]
                                                    ['perguntas'][i],
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                ),
                                              ),
                                              Radio(
                                                value: i,
                                                onChanged: (value) {
                                                  enquetesController
                                                      .index.value = value;
                                                },
                                                groupValue: enquetesController
                                                    .index.value,
                                              )
                                            ],
                                          )
                                        : Text(
                                            enquetesController.enquete[0]
                                                ['perguntas'][i],
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                            ),
                                          ),
                                    enquetesController.enquete[0]
                                                ['verificavoto'] ==
                                            'Não Votou'
                                        ? Container()
                                        : Container(
                                            height: 25,
                                            padding: EdgeInsets.only(top: 10),
                                            child: ProgressIndicatorWidget(
                                              value: enquetesController
                                                              .enquete[0]
                                                          ['votacao'][i] !=
                                                      0
                                                  ? (enquetesController
                                                              .enquete[0]
                                                          ['votacao'][i] /
                                                      enquetesController
                                                          .enquete[0]['soma'])
                                                  : 0,
                                            ),
                                          )
                                  ],
                                )),
                          ),
                        ),
                      enquetesController.enquete[0]['verificavoto'] ==
                              'Não Votou'
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: ButtonTheme(
                                height: 50.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        return Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor;
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
                                    confirmedVote(
                                      'Deseja realmente votar em ${enquetesController.enquete[0]['perguntas'][enquetesController.index.value]}',
                                      () {
                                        enquetesController.votarEnquete();
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Votar',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Text(
                          'Total de votos: ${enquetesController.enquete[0]['soma']}',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                        ),
                      ),
                      enquetesController.enquete[0]['verificavoto'] !=
                              "Não Votou"
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Text(
                                enquetesController.enquete[0]['verificavoto'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor,
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Text(
                          enquetesController.enquete[0]['valida'],
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
