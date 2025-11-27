import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static String? get apiBaseurl => dotenv.env['API_BASE_URL'];
}
