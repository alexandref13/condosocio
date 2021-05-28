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
      appBar: AppBar(),
      body: Obx(
        () {
          return acheAquiController.isLoading.value
              ? CircularProgressIndicatorWidget()
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
                          color: Theme.of(context).accentColor,
                          child: ListTile(
                            title: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                ache.atividade,
                                style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    fontWeight: FontWeight.bold),
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
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
