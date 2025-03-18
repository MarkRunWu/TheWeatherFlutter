import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/injectable.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';

part 'weather.g.dart';

@riverpod
Future<CityForcast?> forcastsNext36Hours(Ref ref, TaiwanCity? city) async {
  if (city == null) {
    return null;
  }
  WeatherAPI api = getIt();
  final r = await api.getForcasts36Hours(city);
  final Map<String, Map<String, TimeRange>> propertiesByDate = {};
  for (final element in r.records.locations.first.weatherElements) {
    for (final time in element.timeRanges) {
      propertiesByDate.putIfAbsent(time.startTime, () => {});
      propertiesByDate[time.startTime]!.putIfAbsent(
        element.elementName,
        () => time,
      );
    }
  }
  return CityForcast(
    city: city,
    records:
        propertiesByDate.values.map((property) {
          return ForcastRecord(
            start: DateTime.parse(property["CI"]!.startTime),
            end: DateTime.parse(property["CI"]!.endTime),
            minTemperature: Temperature(
              value: property["MinT"]!.parameter.parameterName,
              unit: property["MinT"]!.parameter.parameterUnit ?? "C",
            ),
            maxTemperature: Temperature(
              value: property["MaxT"]!.parameter.parameterName,
              unit: property["MaxT"]!.parameter.parameterUnit ?? "C",
            ),
            rainChance:
                int.parse(property["PoP"]!.parameter.parameterName) / 100.0,
            weatherTerm: property["Wx"]!.parameter.parameterName,
            confortableTerm: property["CI"]!.parameter.parameterName,
          );
        }).toList(),
  );
}
