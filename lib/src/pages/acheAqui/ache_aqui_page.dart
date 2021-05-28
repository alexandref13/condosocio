import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AcheAquiPage extends StatelessWidget {
  final AcheAquiController acheAquiController = Get.put(AcheAquiController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'AUTO';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.swap_horiz,
                              size: 40,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Automóveis",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'COMER';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.person_outline,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Alimentação",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'EDUCACAO';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.live_tv_outlined,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Educação",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'CONSTRUCAO';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.receipt_outlined,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Construção",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'SEGURANCA';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              FontAwesome.calendar_o,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Segurança",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'LIMPEZA';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              FontAwesome.comment_o,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Conservação",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'SAUDE';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              FontAwesome.file_o,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Saúde",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'CASA';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              FontAwesome.comments_o,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Casa",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'HOTEIS';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.event_note_outlined,
                            size: 35,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                          ),
                          Text(
                            "Viagem",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'MODA';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              FontAwesome.cart_plus,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Beleza",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'TRANSPORTE';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Icon(
                              AntDesign.infocirlceo,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Transporte",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    acheAquiController.tema.value = 'OUTROS';
                    acheAquiController.getAcheAqui();
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).buttonColor,
                            spreadRadius: 3,
                            blurRadius: 1,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Icon(
                              Icons.question_answer_outlined,
                              size: 35,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            "Outros",
                            style: GoogleFonts.montserrat(
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
