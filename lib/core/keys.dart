import 'package:flutter_dotenv/flutter_dotenv.dart';

String get stripeApiKey => dotenv.env['STRIPE_API_KEY'] ?? "";

String get stripePublishKey => dotenv.env['STRIPE_PUBLISH_KEY'] ?? "";
