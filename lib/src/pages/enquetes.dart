import 'package:condosocio/src/components/progress_indicator_widget.dart';
import 'package:condosocio/src/controllers/enquetes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Enquetes extends StatelessWidget {
  const Enquetes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EnquetesController enquetesController = Get.put(EnquetesController());

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
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Center(
                    child: Text(
                  'O que você prefere como prioridade?',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              GestureDetector(
                onTap: () {
                  enquetesController.addPerguntaA();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
              GestureDetector(
                onTap: () {
                  enquetesController.addPerguntaB();
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      Text('Total de votos: ${enquetesController.votos.value}'))
            ],
          );
        }),
      ),
    );
  }
}
