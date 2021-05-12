import 'package:condosocio/src/components/utils/delete_alert.dart';
import 'package:condosocio/src/components/utils/edge_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    subtitle: Text(
                      '$data $hora',
                      style: TextStyle(fontSize: 14),
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
                              edgeAlertWidget(context, 'Ocorrência Deletada');
                            },
                          );
                        },
                        child: Text(
                          "Deletar",
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
                              Theme.of(context).primaryColor,
                            )),
                        onPressed: () {},
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
