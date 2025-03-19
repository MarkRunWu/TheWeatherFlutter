import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/injectable.dart';
import 'package:the_weather_flutter/provider/models/forcast.dart';

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
  return r.records.locations.map((location) {
    final Map<String, Map<String, TimeRange>> propertiesByDate = {};
    for (final element in location.weatherElements) {
      for (final time in element.timeRanges) {
        propertiesByDate.putIfAbsent(time.startTime, () => {});
        propertiesByDate[time.startTime]!.putIfAbsent(
          element.elementName,
          () => time,
        );
      }
    }
    final now = DateTime.now();
    return CityForcast(
      city: TaiwanCity.values.firstWhere(
        (v) => v.name == location.locationName,
      ),
      records:
          propertiesByDate.values
              .map((property) {
                var start = DateTime.parse(property["CI"]!.startTime);
                final end = DateTime.parse(property["CI"]!.endTime);
                final hourlyRecords = List<ForcastRecord>.empty(growable: true);
                while (start.isBefore(end)) {
                  final nextStart = start.add(Duration(hours: 1));
                  if (nextStart.isAfter(now)) {
                    hourlyRecords.add(
                      ForcastRecord(
                        start: start,
                        end: nextStart,
                        minTemperature: Temperature(
                          value: property["MinT"]!.parameter.parameterName,
                          unit:
                              property["MinT"]!.parameter.parameterUnit ?? "C",
                        ),
                        maxTemperature: Temperature(
                          value: property["MaxT"]!.parameter.parameterName,
                          unit:
                              property["MaxT"]!.parameter.parameterUnit ?? "C",
                        ),
                        rainChance:
                            int.parse(
                              property["PoP"]!.parameter.parameterName,
                            ) /
                            100.0,
                        weatherTerm: property["Wx"]!.parameter.parameterName,
                        confortableTerm:
                            property["CI"]!.parameter.parameterName,
                      ),
                    );
                  }
                  start = nextStart;
                }

                return hourlyRecords;
              })
              .expand((e) => e)
              .toList(),
    );
  }).toList();
}
