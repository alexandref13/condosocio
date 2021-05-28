import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/acheAqui/detalhes_ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AvaliacaoAcheAqui extends StatelessWidget {
  const AvaliacaoAcheAqui({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetalhesAcheAquiController detalhesAcheAquiController =
        Get.put(DetalhesAcheAquiController());

    return Container(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'Avalie esta empresa',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Theme.of(context).textSelectionTheme.selectionColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          child: Obx(
            () {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      detalhesAcheAquiController.star1.value = true;
                      detalhesAcheAquiController.star2.value = false;
                      detalhesAcheAquiController.star3.value = false;
                      detalhesAcheAquiController.star4.value = false;
                      detalhesAcheAquiController.star5.value = false;
                      detalhesAcheAquiController.star.value = 1;
                    },
                    icon: Icon(detalhesAcheAquiController.star1.value
                        ? Icons.star
                        : Icons.star_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      detalhesAcheAquiController.star1.value = true;
                      detalhesAcheAquiController.star2.value = true;
                      detalhesAcheAquiController.star3.value = false;
                      detalhesAcheAquiController.star4.value = false;
                      detalhesAcheAquiController.star5.value = false;
                      detalhesAcheAquiController.star.value = 2;
                    },
                    icon: Icon(detalhesAcheAquiController.star2.value
                        ? Icons.star
                        : Icons.star_border_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      detalhesAcheAquiController.star1.value = true;
                      detalhesAcheAquiController.star2.value = true;
                      detalhesAcheAquiController.star3.value = true;
                      detalhesAcheAquiController.star4.value = false;
                      detalhesAcheAquiController.star5.value = false;
                      detalhesAcheAquiController.star.value = 3;
                    },
                    icon: Icon(
                      detalhesAcheAquiController.star3.value
                          ? Icons.star
                          : Icons.star_border_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      detalhesAcheAquiController.star1.value = true;
                      detalhesAcheAquiController.star2.value = true;
                      detalhesAcheAquiController.star3.value = true;
                      detalhesAcheAquiController.star4.value = true;
                      detalhesAcheAquiController.star5.value = false;
                      detalhesAcheAquiController.star.value = 4;
                    },
                    icon: Icon(
                      detalhesAcheAquiController.star4.value
                          ? Icons.star
                          : Icons.star_border_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      detalhesAcheAquiController.star1.value = true;
                      detalhesAcheAquiController.star2.value = true;
                      detalhesAcheAquiController.star3.value = true;
                      detalhesAcheAquiController.star4.value = true;
                      detalhesAcheAquiController.star5.value = true;
                      detalhesAcheAquiController.star.value = 5;
                    },
                    icon: Icon(detalhesAcheAquiController.star5.value
                        ? Icons.star
                        : Icons.star_border_outlined),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          child: Obx(
            () {
              return customTextField(
                context,
                'Comente',
                null,
                true,
                3,
                true,
                detalhesAcheAquiController.comentario.value,
              );
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: ButtonTheme(
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Theme.of(context).accentColor;
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  return 3;
                }),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  },
                ),
              ),
              onPressed: () {},
              child: Text(
                "ENVIAR",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ButtonTheme(
            height: 50.0,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    return Theme.of(context).textSelectionTheme.selectionColor;
                  },
                ),
                elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  return 3;
                }),
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (Set<MaterialState> states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    );
                  },
                ),
              ),
              onPressed: () {},
              child: Text(
                "VER AVALIAÇÕES",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              itemCount: detalhesAcheAquiController.avaliacao.length,
              itemBuilder: (_, i) {
                return Container();
              },
            ),
          ),
        )
      ],
    ));
  }
}
