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
                                    AntDesign.infocirlce,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Sobre",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    Icons.person,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Perfil",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    FontAwesome.tv,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "CondoPlay",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/acessos');
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
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Acessos",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    FontAwesome.calendar,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Reservas",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    FontAwesome.comment,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Comunicados",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    FontAwesome.file,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Documentos",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    FontAwesome.comments,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Enquetes",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                  Icons.event_note,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Ocorrências",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Ache Aqui",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    Icons.search,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Classificados",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
                                    FontAwesome.comments,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Ouvidoria",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
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
