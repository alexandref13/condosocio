import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/pages/acheAqui/ache_aqui_page.dart';
import 'package:condosocio/src/pages/acheAqui/pesquisa_ache_aqui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AcheAqui extends StatelessWidget {
  const AcheAqui({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ache Aqui',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              acheAquiController.isSearch.value =
                  !acheAquiController.isSearch.value;
            },
            icon: Icon(
              Icons.search,
              size: 32,
            ),
          )
        ],
      ),
      body: Obx(() {
        return acheAquiController.isSearch.value
            ? PesquisaAcheAqui()
            : AcheAquiPage();
      }),
    );
  }
}
