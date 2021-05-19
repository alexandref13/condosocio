import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBottomTab extends StatefulWidget {
  @override
  _HomeBottomTabState createState() => _HomeBottomTabState();
}

class _HomeBottomTabState extends State<HomeBottomTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Container(
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
                          Get.toNamed('/visualizarAcessos');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Acessos",
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
                          Get.toNamed('/perfil');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Perfil",
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
                          Get.toNamed('/alvoTv');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "CondoPlay",
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
                          Get.toNamed('/convites');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Convites",
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
                          Get.toNamed('/reserva');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Reservas",
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
                          Get.toNamed('/comunicados');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Comunicados",
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
                          Get.toNamed('/documentos');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Documentos",
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
                          Get.toNamed('/enquetes');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Enquetes",
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
                          Get.toNamed('/ocorrencias');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Ocorrências",
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
                          print('Nao tem page aq');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Ache Aqui",
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
                          Get.toNamed('/sobre');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Sobre",
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
                          Get.toNamed('/ouvidoria');
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
                                  offset: Offset(
                                      0, 2), // changes position of shadow
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
                                  "Ouvidoria",
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
          ),
        ),
      ],
    );
  }
}
