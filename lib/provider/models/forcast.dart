import 'package:equatable/equatable.dart';
import 'package:the_weather_flutter/api/models/city.dart';

class Temperature extends Equatable {
  final String value;
  final String unit;

  const Temperature({required this.value, required this.unit});

  @override
  String toString() {
    return "$value$unit";
  }

  @override
  List<Object?> get props => [value, unit];
}

class ForcastRecord extends Equatable {
  final String weatherTerm;
  final Temperature maxTemperature;
  final Temperature minTemperature;
  final num? rainChance;
  final DateTime start;
  final DateTime end;
  final String confortableTerm;

  const ForcastRecord({
    required this.start,
    required this.end,
    required this.weatherTerm,
    required this.maxTemperature,
    required this.minTemperature,
    required this.rainChance,
    required this.confortableTerm,
  });
  @override
  List<Object?> get props => [
    weatherTerm,
    maxTemperature,
    minTemperature,
    rainChance,
    start,
    end,
    confortableTerm,
  ];
}

class CityForcast extends Equatable {
  final TaiwanCity city;
  final List<ForcastRecord> records;

  const CityForcast({required this.city, required this.records});

  @override
  List<Object?> get props => [city, records];
}
