import 'package:condosocio/src/components/progress_indicator_widget.dart';
import 'package:condosocio/src/controllers/enquetes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Enquetes extends StatelessWidget {
  const Enquetes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnquetesController enquetesController = Get.put(EnquetesController());
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Enquete'),
      ),
      body: Container(
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              enquetesController.isSelected.value
                  ? Container(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Center(
                        child: Text(
                          'Obrigado por votar!',
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Center(
                    child: Text(
                  'O que você prefere como prioridade?',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              enquetesController.votos.value == 0
                  ? GestureDetector(
                      onTap: () {
                        if (!enquetesController.isSelected.value) {
                          enquetesController.addPerguntaA();
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).buttonColor,
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Calçamentos nas garagens ',
                              ),
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(top: 10),
                                child: ProgressIndicatorWidget(
                                  value: 0,
                                ),
                              )
                            ],
                          )),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (!enquetesController.isSelected.value) {
                          enquetesController.addPerguntaA();
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).buttonColor,
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Calçamentos nas garagens (${((enquetesController.perguntaA.value / enquetesController.votos.value) * 100).toStringAsFixed(2)}%)',
                              ),
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(top: 10),
                                child: ProgressIndicatorWidget(
                                  value: enquetesController.perguntaA.value /
                                      enquetesController.votos.value,
                                ),
                              )
                            ],
                          )),
                    ),
              enquetesController.votos.value == 0
                  ? GestureDetector(
                      onTap: () {
                        if (!enquetesController.isSelected.value) {
                          enquetesController.addPerguntaB();
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).buttonColor,
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Portões nas entradas dos blocos'),
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(top: 10),
                                child: ProgressIndicatorWidget(
                                  value: 0,
                                ),
                              )
                            ],
                          )),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (!enquetesController.isSelected.value) {
                          enquetesController.addPerguntaB();
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).buttonColor,
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  'Portões nas entradas dos blocos (${((enquetesController.perguntaB.value / enquetesController.votos.value) * 100).toStringAsFixed(2)}%)'),
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(top: 10),
                                child: ProgressIndicatorWidget(
                                  value: enquetesController.perguntaB.value /
                                      enquetesController.votos.value,
                                ),
                              )
                            ],
                          )),
                    ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child:
                    Text('Total de votos: ${enquetesController.votos.value}'),
              ),
              enquetesController.isSelected.value
                  ? Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Text(
                          'Você votou dia: ${DateFormat("dd/MM/yyyy").format(enquetesController.date.value)}'),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  'Votações encerradas',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
