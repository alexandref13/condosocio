import 'package:condosocio/src/pages/perfil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBottomTab extends StatefulWidget {
  @override
  _HomeBottomTabState createState() => _HomeBottomTabState();
}

class _HomeBottomTabState extends State<HomeBottomTab> {
  Future<void> goToProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String id = prefs.getString('idusu');

    final String nome = prefs.getString('nome');
    final String tipo = prefs.getString('tipo');
    final String imgperfil = prefs.getString('imgperfil');
    final String email = prefs.getString('email');

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Perfil(id, nome, tipo, imgperfil, email)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Não tem page aq');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Icon(
                                  FontAwesome.picture_o,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Galeria",
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                "Alvo TV",
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Icon(
                                  FontAwesome.arrows_h,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Acessos",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Não tem page aq');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        goToProfile();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
                            borderRadius: BorderRadius.circular(100),
                            color: Theme.of(context).accentColor,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff103845),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset:
                                    Offset(0, 2), // changes position of shadow
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
                                style: GoogleFonts.poppins(
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
    );
  }
}
