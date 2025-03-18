import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppConfig {
  final String weatherApiKey;

  const AppConfig({required this.weatherApiKey});

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> create() async {
    await dotenv.load(fileName: ".env");
    return AppConfig(weatherApiKey: dotenv.env["WEATHER_API_KEY"] ?? '');
  }
}
