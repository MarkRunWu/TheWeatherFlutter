import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/injectable.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';
import 'package:the_weather_flutter/provider/models/forcast_ext.dart';

part 'weather.g.dart';

@riverpod
Future<List<CityForcast>> forcastsNext36Hours(
  Ref ref,
  List<TaiwanCity> cities,
) async {
  if (cities.isEmpty) {
    return List.empty();
  }
  WeatherAPI api = getIt();
  final op = api.getForcasts36Hours(cities);

  ref.onDispose(op.cancel);
  final r = await op.future();
  final now = DateTime.now();
  return r.records.locations
      .map((location) => CityForcastMapper.from(location, dateTimeAfter: now))
      .toList();
}
