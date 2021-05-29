// import 'package:condosocio/src/components/utils/circular_progress_indicator.dart';
// import 'package:condosocio/src/components/utils/progress_indicator_widget.dart';
// import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
// import 'package:condosocio/src/controllers/enquetes/votar_enquete.dart';
// import 'package:condosocio/src/controllers/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class InfoEnquetes extends StatelessWidget {
//   final VotarEnqueteController enquetesController =
//       Get.put(VotarEnqueteController());

//   final VisualizarEnquetesController visualizarEnquetesController =
//       Get.put(VisualizarEnquetesController());

//   final LoginController loginController = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Get.offNamed('/enquetes');
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Obx(() {
//           return enquetesController.isLoading.value
//               ? CircularProgressIndicatorWidget()
//               : SingleChildScrollView(
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Container(
//                           child: Center(
//                             child: Text(
//                               loginController.nome.value,
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 12, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           child: Center(
//                             child: Text(
//                               'Obrigado pela sua participação',
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 40),
//                           child: Center(
//                               child: Text(
//                             visualizarEnquetesController.titulo.value,
//                             style: GoogleFonts.montserrat(
//                               fontSize: 12,
//                             ),
//                           )),
//                         ),
//                         for (var i = 0;
//                             i < enquetesController.enquete[0]['qdtperguntas'];
//                             i++)
//                           Container(
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: Theme.of(context).accentColor,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Theme.of(context).buttonColor,
//                                         spreadRadius: 3,
//                                         blurRadius: 1,
//                                         offset: Offset(
//                                             0, 2), // changes position of shadow
//                                       ),
//                                     ],
//                                   ),
//                                   margin: EdgeInsets.symmetric(
//                                     vertical: 20,
//                                     horizontal: 10,
//                                   ),
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Text(
//                                         enquetesController.enquete[0]
//                                             ['perguntas'][i],
//                                         style: GoogleFonts.montserrat(
//                                           fontSize: 12,
//                                           color: Theme.of(context)
//                                               .textSelectionTheme
//                                               .selectionColor,
//                                         ),
//                                       ),
//                                       Container(
//                                         height: 25,
//                                         padding: EdgeInsets.only(top: 10),
//                                         child: ProgressIndicatorWidget(
//                                           value: enquetesController.enquete[0]
//                                                       ['votacao'][i] !=
//                                                   0
//                                               ? (enquetesController.enquete[0]
//                                                       ['votacao'][i] /
//                                                   enquetesController.enquete[0]
//                                                       ['soma'])
//                                               : 0,
//                                         ),
//                                       )
//                                     ],
//                                   )),
//                             ),
//                           ),
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 20, horizontal: 10),
//                           child: Text(
//                             'Total de votos: ${enquetesController.enquete[0]['soma']}',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 12,
//                               color: Theme.of(context)
//                                   .textSelectionTheme
//                                   .selectionColor,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 20, horizontal: 10),
//                           child: Text(
//                             enquetesController.enquete[0]['verificavoto'],
//                             style: GoogleFonts.montserrat(
//                               fontSize: 12,
//                               color: Theme.of(context)
//                                   .textSelectionTheme
//                                   .selectionColor,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.symmetric(
//                               vertical: 20, horizontal: 10),
//                           child: Text(
//                             enquetesController.enquete[0]['valida'],
//                             style: GoogleFonts.montserrat(
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//         }),
//       ),
//     );
//   }
// }
