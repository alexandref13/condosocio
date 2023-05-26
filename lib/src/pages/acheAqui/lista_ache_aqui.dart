import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListaAcheAqui extends StatelessWidget {
  final AcheAquiController acheAquiController = Get.put(AcheAquiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          acheAquiController.tema.value,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      body: Obx(
        () {
          return acheAquiController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : acheAquiController.acheAqui.length == 0
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
                        itemCount: acheAquiController.acheAqui.length,
                        itemBuilder: (_, i) {
                          var ache = acheAquiController.acheAqui[i];
                          return GestureDetector(
                            onTap: () {
                              acheAquiController.id.value = ache.id;
                              acheAquiController.getAcheAquiForm();
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                              child: ListTile(
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    ache.atividade,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor!,
                                        fontWeight: FontWeight.bold),
                                  ),
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
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
