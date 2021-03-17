import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void configurandoModalBottomSheet(
  context,
  String data,
  String hora,
  String titulo,
  String dataoco,
  String horaoco,
  String status,
) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: EdgeInsets.all(8),
        color: Theme.of(context).accentColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Text(
                titulo,
                style: GoogleFonts.montserrat(
                    fontSize: 24,
                    color: Theme.of(context).textSelectionTheme.selectionColor),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Data da ocorrência',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                        Text(
                          dataoco,
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hora da ocorrência',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                        Text(
                          horaoco,
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: status == '1'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ocorrencia Finalizada',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor),
                                ),
                                Icon(
                                  Feather.check,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ocorrencia em andamento',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor),
                                ),
                                Icon(
                                  Feather.alert_triangle,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ],
                            )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFFD11A2A);
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      Icons.delete,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.white;
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      FontAwesome.heart,
                      size: 30,
                      color: Color(0xFFD11A2A),
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Color(0xFF075e54);
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      FontAwesome.whatsapp,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                          return 3;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Colors.white;
                        },
                      ),
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          );
                        },
                      ),
                    ),
                    child: Icon(
                      FontAwesome.telegram,
                      size: 30,
                      color: Color(0xFF0088CC),
                    ),
                  ),
                  // RaisedButton(
                  //   elevation: 3,
                  //   onPressed: () {},
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0)),
                  //   child: Icon(
                  //     FontAwesome.telegram,
                  //     size: 30,
                  //     color: Color(0xFF0088CC),
                  //   ),
                  //   color: Colors.white,
                  // ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
