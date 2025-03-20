import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:the_weather_flutter/api/weather.dart';

import '../mock/weather_api.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  generateForDir: ["test"],
  initializerName: "initTest",
  preferRelativeImports: true,
)
void configureTestDependencies() => getIt.initTest();

mockAPI(MockWeatherAPI api) {
  (getIt<WeatherAPI>() as MockWeatherAPI).setInterceptor(api);
}

resetMockAPI() {
  (getIt<WeatherAPI>() as MockWeatherAPI).setInterceptor(null);
}
