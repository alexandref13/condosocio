import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastCenter(BuildContext context, String title, String description) {
  String message = '$title\n$description';

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: (const Color.fromARGB(255, 23, 121, 26)),
    textColor: Colors.white,
    fontSize: 20.0,
    timeInSecForIosWeb: 3,
  );
}

/*showToast(context, String title, String description) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.BOTTOM,
    backgroundColor: Colors.green,
    icon: Icons.done,
    description: description,
  );
}*/
