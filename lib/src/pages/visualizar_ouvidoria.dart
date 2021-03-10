import 'package:condosocio/src/components/box_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class VisualizarOuvidoria extends StatefulWidget {
  @override
  _VisualizarOuvidoriaState createState() => _VisualizarOuvidoriaState();
}

class _VisualizarOuvidoriaState extends State<VisualizarOuvidoria> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar Ouvidoria'),
      ),
      body: Column(
        children: [
          boxSearch(context, search, ''),
          Container(
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                Text(
                  'Hora',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                Text(
                  'Assunto',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
                Text(
                  'Respostas',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(width: 1, color: Colors.grey),
                )),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '13/02/2021',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '20:56',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: Text(
                        'Coco de cachorro',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            '13/02/2021',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '20:58',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(
                        FontAwesome.clock_o,
                        size: 40,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
