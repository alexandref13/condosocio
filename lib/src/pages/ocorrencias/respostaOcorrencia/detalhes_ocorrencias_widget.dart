import 'package:condosocio/src/controllers/visualizar_ocorrencias_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalhesOcorrenciasWidget extends StatelessWidget {
  final VisualizarOcorrenciasController ocorrenciasController =
      Get.put(VisualizarOcorrenciasController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'Criado',
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
                                ocorrenciasController.dataoco.value,
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
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          ocorrenciasController.houroco.value,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Respondido',
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
                                ocorrenciasController.data.value,
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
                    top: 20,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                        size: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          ocorrenciasController.hour.value,
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
            margin: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                )),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Feather.user_check),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .55,
                            child: Text(
                              ocorrenciasController.titulo.value,
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
                            width: MediaQuery.of(context).size.width * .55,
                            child: Text(
                              ocorrenciasController.descricao.value,
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
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
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        FontAwesome.whatsapp,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                      onPressed: () {},
                    )
                  ],
                ))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(
                top: BorderSide(
                  width: .5,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ButtonTheme(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            return Theme.of(context).errorColor;
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
                        "Deletar",
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
