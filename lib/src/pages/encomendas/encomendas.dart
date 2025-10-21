import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/encomendas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Encomendas extends StatelessWidget {
  final EncomendasController encomendasController =
      Get.put(EncomendasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.offNamed('/home');
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            'Encomendas',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor!,
            ),
          )),
      body: Obx(
        () {
          return encomendasController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : encomendasController.encomendas.length == 0
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
                                'Sem registros',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0,
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .selectionColor!,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : Container(
                      child: ListView.builder(
                        itemCount: encomendasController.encomendas.length,
                        itemBuilder: (_, i) {
                          var encomenda = encomendasController.encomendas[i];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  encomendasController.id.value =
                                      encomenda.idenc;
                                  encomendasController.idcript.value =
                                      encomenda.idcript;
                                  encomendasController.codigo.value =
                                      encomenda.codigo;
                                  encomendasController.tipo.value =
                                      encomenda.tipo;
                                  encomendasController.info.value =
                                      encomenda.info;
                                  encomendasController.status.value =
                                      encomenda.status;
                                  encomendasController.morador.value =
                                      encomenda.morador;
                                  encomendasController.admCriador.value =
                                      encomenda.admCriador;
                                  encomendasController.dataCriada.value =
                                      encomenda.dataCriada;
                                  encomendasController.admEntrega.value =
                                      encomenda.admEntrega;
                                  encomendasController.dataEntrega.value =
                                      encomenda.dataEntrega;

                                  Get.toNamed('/detalhesEncomendas');
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: encomenda.status !=
                                          'PRONTO PRA RETIRADA'
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).primaryColorDark,
                                  child: ListTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          encomenda.dataCriada,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                          ),
                                        ),
                                        Text(
                                          encomenda.codigo.length > 14
                                              ? "${encomenda.codigo.substring(0, 14)}..."
                                              : encomenda.codigo,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor!,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                    subtitle: Text(
                                      encomenda.tipo,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .textSelectionTheme
                                              .selectionColor),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_right,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor!,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
