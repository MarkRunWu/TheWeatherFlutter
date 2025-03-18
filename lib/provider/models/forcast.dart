import 'package:the_weather_flutter/api/models/city.dart';

class Temperature {
  final String value;
  final String unit;

  const Temperature({required this.value, required this.unit});

  @override
  String toString() {
    return "$value$unit";
  }
}

class ForcastRecord {
  final String weatherTerm;
  final Temperature maxTemperature;
  final Temperature minTemperature;
  final num? rainChance;
  final DateTime start;
  final DateTime end;
  final String confortableTerm;

  ForcastRecord({
    required this.start,
    required this.end,
    required this.weatherTerm,
    required this.maxTemperature,
    required this.minTemperature,
    required this.rainChance,
    required this.confortableTerm,
  });
}

class CityForcast {
  final TaiwanCity city;
  final List<ForcastRecord> records;

  CityForcast({required this.city, required this.records});
}
