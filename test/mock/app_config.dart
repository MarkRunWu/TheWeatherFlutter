import 'package:injectable/injectable.dart';
import 'package:the_weather_flutter/app_config.dart';

@Singleton(as: AppConfig)
class MockAppConfig extends AppConfig {
  @override
  String get weatherApiKey => '';

  @override
  int get debounceMilliSec => 0;
  MockAppConfig();
}
