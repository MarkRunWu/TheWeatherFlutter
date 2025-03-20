import 'package:injectable/injectable.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';
import 'package:the_weather_flutter/api/weather.dart';

import 'data.dart';

@test
@Singleton(as: WeatherAPI)
class MockWeatherAPI implements WeatherAPI {
  MockWeatherAPI? _interceptor;

  setInterceptor(MockWeatherAPI? interceptor) {
    _interceptor = interceptor;
  }

  @override
  CancellableFuture<ForcastsResponse> getForcasts36Hours(
    List<TaiwanCity> cities,
  ) {
    return _interceptor?.getForcasts36Hours(cities) ??
        CancellableFuture<ForcastsResponse>(
          () async => Future.value(mockForcastsResponse),
          () {},
        );
  }
}
