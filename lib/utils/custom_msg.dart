import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showCustomMsg(BuildContext context, String msg, {Color? bgColor}) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(content: Text(msg), backgroundColor: bgColor ?? Colors.grey),
  );
}
