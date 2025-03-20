import 'package:injectable/injectable.dart';
import 'package:the_weather_flutter/app_config.dart';

@test
@Singleton(as: AppConfig)
class MockAppConfig extends AppConfig {
  MockAppConfig() : super(weatherApiKey: '', debounceMilliSec: 0);
}
