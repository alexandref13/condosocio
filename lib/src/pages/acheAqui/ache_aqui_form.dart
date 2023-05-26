import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AcheAquiForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() {
          return acheAquiController.isLoading.value
              ? CircularProgressIndicatorWidget()
              : acheAquiController.acheAquiForm.length == 0
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
                                      .selectionColor,
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
                        itemCount: acheAquiController.acheAquiForm.length,
                        itemBuilder: (_, i) {
                          var acheAqui = acheAquiController.acheAquiForm[i];
                          return GestureDetector(
                            onTap: () {
                              acheAquiController.empresa.value =
                                  acheAqui.fantasia;

                              acheAquiController.idForm.value = acheAqui.id;
                              acheAquiController.getAcheAquiDetalhes();
                            },
                            child: Container(
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
                                      acheAqui.fantasia,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Container(
                                    padding: EdgeInsets.only(left: 15, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        acheAqui.end != ''
                                            ? Container(
                                                child: Text(
                                                  acheAqui.end,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${acheAqui.bairro} | ${acheAqui.cidade} - ${acheAqui.uf}',
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    child: Image(
                                      image: NetworkImage(acheAqui.imgforn),
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
        }));
  }
}
