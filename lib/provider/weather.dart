import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/injectable.dart';

part 'weather.g.dart';

@riverpod
Future<List<WeatherElement>> forcastsNext36Hours(
  Ref ref,
  TaiwanCity city,
) async {
  WeatherAPI api = getIt();
  final r = await api.getForcasts36Hours(city);
  return r.records.locations.first.weatherElements;
}
