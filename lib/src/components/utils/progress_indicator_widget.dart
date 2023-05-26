import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double? value;
  const ProgressIndicatorWidget({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(
        Colors.green,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
