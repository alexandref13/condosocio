import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget customTextField(
    BuildContext context,
    String hintText,
    String labelText,
    bool linesBool,
    int lines,
    int caracteres,
    bool enabled,
    TextEditingController controller) {
  return TextField(
    textCapitalization: TextCapitalization.words,
    onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild!.unfocus();
      }
    },
    maxLength: linesBool ? caracteres : null,
    controller: controller,
    maxLines: linesBool ? lines : 1,
    style: GoogleFonts.montserrat(
      fontSize: 14,
      color: Theme.of(context).textSelectionTheme.selectionColor!,
    ),
    decoration: InputDecoration(
      counterStyle: TextStyle(
        color: Theme.of(context).textSelectionTheme.selectionColor!,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).textSelectionTheme.selectionColor!,
          width: 1,
        ),
      ),
      enabled: enabled,
      hintText: hintText,
      hintStyle: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).textSelectionTheme.selectionColor!,
      ),
      labelText: labelText,
      labelStyle: GoogleFonts.montserrat(
        fontSize: 14,
        color: Theme.of(context).textSelectionTheme.selectionColor!,
      ),
      isDense: false,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).textSelectionTheme.selectionColor!,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Theme.of(context).textSelectionTheme.selectionColor!,
          width: 1,
        ),
      ),
    ),
  );
}
