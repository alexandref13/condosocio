import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

edgeAlertWidget(context, String title) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.BOTTOM,
    backgroundColor: Theme.of(context).accentColor,
    icon: Icons.done,
  );
}
