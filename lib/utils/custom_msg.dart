import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showCustomMsg(
  BuildContext context,
  String msg, {
  Color? bgColor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: bgColor ?? Colors.grey),
  );
}
