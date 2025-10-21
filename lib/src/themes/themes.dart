import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData admin = ThemeData(
  primaryColor: Color(0xff1A936F),
  primaryColorDark: Color.fromARGB(255, 22, 58, 47),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffF3E9D2),
  ),
  scaffoldBackgroundColor: Color(0xff1A936F),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Color(0xffe2e3d3)),
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff1A936F),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff114B5F))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData magenta = ThemeData(
  primaryColor: Color(0xff833545),
  primaryColorDark: Color.fromARGB(255, 58, 30, 35),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xff833545),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff833545),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff49182d))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData turquoise = ThemeData(
  primaryColor: Color(0xff054437),
  primaryColorDark: Color.fromARGB(255, 16, 41, 36),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xff054437),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff054437),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff247557))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData blue = ThemeData(
  primaryColor: Color(0xFF0C668D),
  primaryColorDark: Color.fromARGB(255, 16, 32, 43),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xFF0C668D),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xFF0C668D),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff2a5571))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData grayscale = ThemeData(
  primaryColor: Color(0xff150811),
  primaryColorDark: Color.fromARGB(255, 99, 4, 70),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xff140110),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff150811),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff380036))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData red = ThemeData(
  primaryColor: Color(0xff811308),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xff811308),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff811308),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xffb83a2d))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData orange = ThemeData(
  primaryColor: Color(0xff792404),
  primaryColorDark: Color.fromARGB(255, 67, 34, 22),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xff792404),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff792404),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff8b410d))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData violet = ThemeData(
  primaryColor: Color.fromARGB(255, 130, 10, 209),
  primaryColorDark: Color.fromARGB(255, 47, 22, 63),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 130, 10, 209),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 130, 10, 209),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: Color.fromARGB(198, 12, 14, 145),
      )
      .copyWith(error: Color(0xffa3000b)),
);
