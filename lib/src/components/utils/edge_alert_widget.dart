import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

edgeAlertWidget(context, String title, String description) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.BOTTOM,
    backgroundColor: Colors.green,
    icon: Icons.done,
    description: description,
  );
}
