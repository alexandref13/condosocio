import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Convites extends StatelessWidget {
  final AcessosController acessosController = Get.put(AcessosController());
  final ConvitesController convitesController = Get.put(ConvitesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convites'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              customTextField(context, 'Qual o nome do seu convidado', null,
                  false, null, true, acessosController.name.value),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 28,
                      bottom: 20,
                    ),
                    child: Text(
                      'Quando irá acontecer?',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Text('Inicio do evento'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          child: customTextField(
                            context,
                            null,
                            (DateFormat("dd/MM/yyyy")
                                .format(convitesController.date.value)),
                            false,
                            1,
                            false,
                            convitesController.dataController.value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: customTextField(
                          context,
                          null,
                          (DateFormat("hh:mm")
                              .format(convitesController.date.value)),
                          false,
                          1,
                          false,
                          convitesController.dataController.value,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('Término do evento'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          child: customTextField(
                            context,
                            null,
                            (DateFormat("dd/MM/yyyy")
                                .format(convitesController.date.value)),
                            false,
                            1,
                            false,
                            convitesController.dataController.value,
                          ),
                        ),
                      ),
                      Expanded(
                        child: customTextField(
                          context,
                          null,
                          (DateFormat("hh:mm")
                              .format(convitesController.date.value)),
                          false,
                          1,
                          false,
                          convitesController.dataController.value,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 28,
                      bottom: 20,
                    ),
                    child: Text(
                      'Quem são os convidados?',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context).accentColor;
                          },
                        ),
                        elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                            return 3;
                          },
                        ),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            );
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Adicionar contato da agenda",
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Text('OU'),
                    ),
                  ),
                  ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context).accentColor;
                          },
                        ),
                        elevation: MaterialStateProperty.resolveWith<double>(
                          (Set<MaterialState> states) {
                            return 3;
                          },
                        ),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                          (Set<MaterialState> states) {
                            return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                width: 1,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            );
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Insira um número de celular",
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(top: 15),
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //             width: 1,
                  //             color: Theme.of(context)
                  //                 .textSelectionTheme
                  //                 .selectionColor))),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: ButtonTheme(
                      height: 50.0,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Theme.of(context).accentColor;
                            },
                          ),
                          elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                              return 3;
                            },
                          ),
                          shape:
                              MaterialStateProperty.resolveWith<OutlinedBorder>(
                            (Set<MaterialState> states) {
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              );
                            },
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Enviar",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
