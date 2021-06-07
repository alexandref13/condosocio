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
              padding: const EdgeInsets.only(top: 150),
              
              child: Center(
                child: Column(
                  children: [
                    
                    QrImage(
                      data: encomendasController.idcript.value,
                      version: QrVersions.auto,
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      size: 220.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                      child: Text(
                          'Para receber sua encomenda abra este QR Code na presença da pessoa responsável pelas entregas na administração do condomínio.'),
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
