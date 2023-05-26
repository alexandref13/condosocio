import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData admin = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xff1A936F),
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
  brightness: Brightness.light,
  primaryColor: Color(0xff833545),
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
  brightness: Brightness.dark,
  primaryColor: Color(0xff054437),
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
  brightness: Brightness.dark,
  primaryColor: Color(0xff375a70),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Color(0xffe2e3d3),
  ),
  scaffoldBackgroundColor: Color(0xff375a70),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xffe2e3d3)),
    titleTextStyle: GoogleFonts.montserrat(
      fontSize: 16,
      color: Color(0xffe2e3d3),
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Color(0xff375a70),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Color(0xff2a5571))
      .copyWith(error: Color(0xffa3000b)),
);

ThemeData grayscale = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xff150811),
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
  brightness: Brightness.dark,
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
  brightness: Brightness.dark,
  primaryColor: Color(0xff792404),
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
