import 'package:flutter_dotenv/flutter_dotenv.dart';

String get stripeApiKey => dotenv.env['STRIPE_API_KEY'] ?? "";

String get stripePublishKey => dotenv.env['STRIPE_PUBLISH_KEY'] ?? "";


String mapKey = "AIzaSyBA86ys7XIXX5LrEJZwxPK_r2PYGW50heg";