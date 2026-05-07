import 'package:condosocio/src/components/condo_nav_bar.dart';
import 'package:condosocio/src/components/lista_videos_alvo_tv.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/alvo_tv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AlvoTv extends StatefulWidget {
  @override
  State<AlvoTv> createState() => _AlvoTvState();
}

class _AlvoTvState extends State<AlvoTv> {
  late final AlvoTvController alvoTv;

  @override
  void initState() {
    super.initState();
    alvoTv = Get.put(AlvoTvController());
  }

  @override
  void dispose() {
    Get.delete<AlvoTvController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offNamed('/home'),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'CondoPlay',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      bottomNavigationBar: const CondoNavBar(activeIndex: 3),
      body: Obx(
        () => alvoTv.isLoading.value
            ? CircularProgressIndicatorWidget()
            : listaVideos(context),
      ),
    );
  }
}
