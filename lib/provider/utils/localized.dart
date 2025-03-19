import 'package:the_weather_flutter/provider/models/forcast.dart';

extension LocalizedDateTime on DateTime {
  String get localizedHour {
    final isPM = hour > 12;
    final hourIn12Hours = isPM ? hour - 12 : hour;

    return "${isPM ? "下午" : "上午"}${hourIn12Hours == 0 ? 12 : hourIn12Hours}時";
  }
}

extension LocalizedTemperature on Temperature {
  String get localized {
    return "$value${unit == "C" ? "°C" : " °F"}";
  }
}
