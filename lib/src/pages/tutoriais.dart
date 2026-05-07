import 'package:condosocio/src/components/lista_videos_tutoriais.dart';
import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
import 'package:condosocio/src/controllers/tutoriais_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:condosocio/src/components/condo_nav_bar.dart';

class Tutoriais extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TutoriaisController tutoriais = Get.put(TutoriaisController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offNamed('/home');
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Tutoriais',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Theme.of(context).textSelectionTheme.selectionColor!,
          ),
        ),
      ),
      bottomNavigationBar: CondoNavBar(),
      body: Obx(
        () {
          return tutoriais.isLoading.value
              ? CircularProgressIndicatorWidget()
              : listaVideosTutoriais(context);
        },
      ),
    );
  }
}
