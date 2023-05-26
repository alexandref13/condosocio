import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastError(BuildContext context, String title) {
  Fluttertoast.showToast(
    msg: title,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Theme.of(context).colorScheme.error,
    textColor: Colors.white,
    fontSize: 16.0,
    timeInSecForIosWeb: 1,
  );
}
/*showToastError(context, String title) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.BOTTOM,
    backgroundColor: Theme.of(context).colorScheme.error,
    icon: Icons.highlight_off,
  );
}*/


