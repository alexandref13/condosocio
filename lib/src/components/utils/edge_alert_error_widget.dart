import 'package:edge_alert/edge_alert.dart';
import 'package:flutter/material.dart';

edgeAlertErrorWidget(context, String title) {
  return EdgeAlert.show(
    context,
    title: title,
    gravity: EdgeAlert.BOTTOM,
    backgroundColor: Theme.of(context).errorColor,
    icon: Icons.highlight_off,
  );
}
