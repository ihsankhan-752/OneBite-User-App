import 'package:flutter/material.dart';
import 'package:onebite_user_app/constants/app_colors.dart';
import 'package:onebite_user_app/utils/custom_msg.dart';

void showOrderStatusDialog({
  required String title,
  required String message,
  required String status,
}) {
  final context = navigatorKey.currentContext;
  if (context == null) return;

  IconData iconData;
  Color iconColor;

  switch (status.toLowerCase()) {
    case 'confirmed':
      iconData = Icons.check_circle_outline_rounded;
      iconColor = Colors.green;
      break;
    case 'cancelled':
    case 'rejected':
      iconData = Icons.cancel_outlined;
      iconColor = Colors.red;
      break;
    case 'preparing':
      iconData = Icons.soup_kitchen_rounded;
      iconColor = Colors.orange;
      break;
    case 'on_the_way':
    case 'out for delivery':
      iconData = Icons.delivery_dining_rounded;
      iconColor = Colors.amber;
      break;
    case 'delivered':
      iconData = Icons.done_all_rounded;
      iconColor = Colors.blue;
      break;
    default:
      iconData = Icons.info_outline_rounded;
      iconColor = AppColors.primaryColor;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white12, width: 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 15.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  size: 52,
                  color: iconColor,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Got It!",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
