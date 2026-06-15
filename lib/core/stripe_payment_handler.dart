import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> stripePaymentHandler({
  required String clientSecret,
  required BuildContext context,
}) async {
  await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: "OneBite",
      style: ThemeMode.dark,
    ),
  );

  await Stripe.instance.presentPaymentSheet();
}
