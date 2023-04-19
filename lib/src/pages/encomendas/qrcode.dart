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
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Flexible(
                    child: Container(
                      //color: Color(0xfff5f5f5),
                      child: Image.asset(
                        'images/qrcodeBanner2.png',
                        width: 400,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  QrImage(
                    data: encomendasController.idcript.value,
                    version: QrVersions.auto,
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    size: 240,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
