import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dependentes extends StatefulWidget {
  @override
  _DependentesState createState() => _DependentesState();
}

class _DependentesState extends State<Dependentes> {
  DependentesController dependentesController =
      Get.put(DependentesController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Dependentes',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                AntDesign.infocirlce,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(8),
            height: MediaQuery.of(context).size.height * .95,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Nome: ',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  null,
                  false,
                  1,
                  true,
                  dependentesController.nome.value,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Sobrenome: ',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  null,
                  false,
                  1,
                  true,
                  dependentesController.sobrenome.value,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Email: ',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  null,
                  false,
                  1,
                  true,
                  dependentesController.email.value,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Gênero: ',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color:
                          Theme.of(context).textSelectionTheme.selectionColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                customTextField(
                  context,
                  null,
                  null,
                  false,
                  1,
                  true,
                  dependentesController.genero.value,
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonTheme(
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
                      "INCLUIR",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          return Theme.of(context)
                              .textSelectionTheme
                              .selectionColor;
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
                      "VISUALIZE DEPENDENTES",
                      style: GoogleFonts.montserrat(
                          color: Theme.of(context).buttonColor, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
