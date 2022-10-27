import 'package:condosocio/src/components/lista_videos_alvo_tv.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/alvo_tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AlvoTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AlvoTvController alvoTv = Get.put(AlvoTvController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'CondoPlay',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
        ),
      ),
      body: Obx(
        () {
          return alvoTv.isLoading.value
              ? CircularProgressIndicatorWidget()
              : listaVideos(context);
        },
      ),
    );
  }
}
