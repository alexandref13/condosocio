import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RespostaOcorrenciaWidget extends StatelessWidget {
  const RespostaOcorrenciaWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var i = 1;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment:
              i == 1 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Theme.of(context).accentColor,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Alexandre',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                          Text(
                            '20:20',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'ola',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: Theme.of(context).textSelectionTheme.selectionColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {},
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Theme.of(context).accentColor,
                ),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).accentColor,
                  hintText: 'Envie uma resposta',
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              iconSize: 25.0,
              color: Theme.of(context).accentColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
