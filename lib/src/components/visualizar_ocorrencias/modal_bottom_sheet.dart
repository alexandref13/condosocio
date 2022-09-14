import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void ocorrenciasModalBottomSheet(
  context,
  String titulo,
  String data,
  String hora,
  String status,
) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          color: Theme.of(context).accentColor,
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: status == '0'
                        ? Icon(
                            Feather.alert_triangle,
                            color: Theme.of(context).errorColor,
                            size: 40,
                          )
                        : Icon(
                            Icons.done,
                            color: Theme.of(context).accentColor,
                            size: 40,
                          ),
                    title: Text(
                      titulo,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    ),
                    subtitle: Text(
                      '$data $hora',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color:
                            Theme.of(context).textSelectionTheme.selectionColor,
                      ),
                    )),
                Divider(
                  height: 20,
                  color: Colors.blueGrey,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).textSelectionTheme.selectionColor,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/respostaOcorrencia');
                        },
                        child: Text(
                          "Respostas",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).errorColor,
                            )),
                        onPressed: () {
                          deleteAlert(
                            context,
                            'Deseja deletar a ocorrência?',
                            () {
                              edgeAlertWidget(context, 'Parabéns!',
                                  'Ocorrência excluída com sucesso.');
                            },
                          );
                        },
                        child: Text(
                          "Deletar",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        );
      });
}
