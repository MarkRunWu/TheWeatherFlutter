import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

abstract class AppConfig {
  String get weatherApiKey;
  int get debounceMilliSec;
}

@Injectable(as: AppConfig)
class AppConfigImpl extends AppConfig {
  @override
  final String weatherApiKey;
  @override
  final int debounceMilliSec;

  AppConfigImpl({
    required this.weatherApiKey,
    this.debounceMilliSec = 500,
  });

  @FactoryMethod(preResolve: true)
  static Future<AppConfig> create() async {
    await dotenv.load(fileName: ".env");
    return AppConfigImpl(weatherApiKey: dotenv.env["WEATHER_API_KEY"] ?? '');
  }
}
