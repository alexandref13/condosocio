import 'package:condosocio/src/controllers/boleto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class VisualizarBoletos extends StatelessWidget {
  BoletoController boletoController = Get.put(BoletoController());
  @override
  Widget build(BuildContext context) {
    var boleto = boletoController.boletos;
    print(boleto.length);

    Future<void> launchInBrowser(String url) async {
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Boletos 2ª Via'),
        ),
        body: boleto.length == 0
            ? Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'images/semregistro.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          //child: Icon(Icons.block, size: 34, color: Colors.red[900]),
                        ),
                        Text(
                          'Você não possui boletos vencidos',
                          style: GoogleFonts.montserrat(
                            fontSize: 20.0,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      for (var i = 0; i < boletoController.boletos.length; i++)
                        GestureDetector(
                          onTap: () {
                            launchInBrowser(boleto[i]['link2viaboleto']);
                          },
                          child: Card(
                            color: Theme.of(context).colorScheme.secondary,
                            child: ListTile(
                              leading: IconButton(
                                icon: Icon(Icons.qr_code),
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                                iconSize: 36,
                                onPressed: () {},
                              ),
                              title: Text(
                                  'Valor Corrigido: R\$ ${boleto[i]['encargos']['valorcorrigido']}'),
                              subtitle: Text(
                                  'Vencido em:  ${getFormatedDate(boleto[i]['dt_vencimento_recb'])}\nDias de atraso: ${boleto[i]['encargos']['diasatraso']}'),
                              trailing: Icon(Icons.more_vert),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ));
  }
}

getFormatedDate(_date) {
  var inputFormat = DateFormat('dd/MM/yyyy HH:mm:ss');
  var inputDate = inputFormat.parse(_date);
  var outputFormat = DateFormat('dd/MM/yyyy');
  return outputFormat.format(inputDate);
}
