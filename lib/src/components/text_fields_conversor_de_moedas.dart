import 'package:flutter/material.dart';

Widget textFields(String label, String prefix, TextEditingController controller, Function changed) {
  return TextFormField(
    onChanged: changed,
    controller: controller,
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.white, fontSize: 14),
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xffa67f00))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffa67f00))),
        prefixText: prefix,
        prefixStyle: TextStyle(color: Colors.white, fontSize: 14),
        labelText: label,
        labelStyle: TextStyle(fontSize: 25, color: Color(0xffa67f00))),
  );
}
