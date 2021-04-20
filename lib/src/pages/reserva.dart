import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Reserva extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas'),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: CustomScrollView(
            primary: false,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 3,
                  children: [
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
                        Get.toNamed('/sobre');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
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
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
