import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class Documentos extends StatefulWidget {
  @override
  _DocumentosState createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Documentos',
          style: GoogleFonts.montserrat(
            fontSize: 20,
          ),
        ),
      ),
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
                        Navigator.pushNamed(context, '/ataDocumentos');
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
                                Icons.file_present,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Atas",
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
                        Navigator.pushNamed(context, '/convencaoDocumentos');
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
                                  Icons.file_present,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Convenção",
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
                        Navigator.pushNamed(context, '/editaisDocumentos');
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
                                  Icons.file_present,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Editais",
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
                        Navigator.pushNamed(context, '/prestacaoDocumentos');
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
                                  Icons.file_present,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Text(
                                  "Prestação de Contas",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/regulamentoDocumentos');
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
                                  Icons.file_present,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Regulamento",
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
                        Navigator.pushNamed(context, '/contratosDocumentos');
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
                                  Icons.file_present,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Contratos",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).accentColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).buttonColor,
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
                                Icons.anchor_outlined,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/outrosDocumentos');
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
                                  Icons.file_present,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Outros",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).accentColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).buttonColor,
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
                                Icons.anchor_outlined,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
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
