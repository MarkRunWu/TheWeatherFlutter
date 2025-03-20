import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@dev
@prod
@injectable
class AppConfig {
  final String weatherApiKey;
  final int debounceMilliSec;

  const AppConfig({required this.weatherApiKey, this.debounceMilliSec = 500});

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> create() async {
    await dotenv.load(fileName: ".env");
    return AppConfig(weatherApiKey: dotenv.env["WEATHER_API_KEY"] ?? '');
  }
}
