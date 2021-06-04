import 'package:condosocio/src/controllers/encomendas_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  final EncomendasController encomendasController =
      Get.put(EncomendasController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Receber com QR Code",
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          'Abra este QR Code na presença de pessoa responsável pelas entregas na administração, para receber a sua encomenda.'),
                    ),
                    QrImage(
                      data: encomendasController.id.value,
                      version: QrVersions.auto,
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      size: 220.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
