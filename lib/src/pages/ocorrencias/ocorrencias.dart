import 'package:condosocio/src/components/utils/custom_text_field.dart';
import 'package:condosocio/src/controllers/ocorrencias_controller.dart';
// import 'package:condosocio/src/services/ocorrencias/api_ocorrencia.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

class Ocorrencias extends StatefulWidget {
  @override
  _OcorrenciasState createState() => _OcorrenciasState();
}

class _OcorrenciasState extends State<Ocorrencias> {
  OcorrenciasController ocorrenciasController =
      Get.put(OcorrenciasController());

  DateTime data = DateTime.now();
  TimeOfDay hora = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Ocorrências',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
            ),
            body: TabBarView(children: [])),
      ),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    ocorrenciasController.itemSelecionado.value = novoItem;
  }
}
