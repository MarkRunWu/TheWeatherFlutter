import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';

abstract class WeatherAPI {
  Future<ForcastsResponse> getForcasts36Hours(List<TaiwanCity> cities);
}
