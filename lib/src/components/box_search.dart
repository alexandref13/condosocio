import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

Widget boxSearch(
  BuildContext context,
  TextEditingController searchController,
  onSearchTextChanged,
) {
  return Container(
    padding: EdgeInsets.all(5),
    child: TextField(
      onChanged: onSearchTextChanged == '' ? null : onSearchTextChanged,
      controller: searchController,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: Theme.of(context).textSelectionTheme.selectionColor,
      ),
      decoration: InputDecoration(
        labelText: "Pesquise pelo nome",
        labelStyle: GoogleFonts.poppins(
          fontSize: 18,
          color: Theme.of(context).textSelectionTheme.selectionColor,
        ),
        prefixIcon: Icon(
          Feather.search,
          color: Theme.of(context).textSelectionTheme.selectionColor,
          size: 23,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textSelectionTheme.selectionColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
