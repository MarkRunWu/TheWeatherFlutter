import 'package:json_annotation/json_annotation.dart';

part 'forcasts.g.dart';

@JsonSerializable()
class ForcastsResponse {
  final String success;
  final Result result;
  final ForcastsRecord records;

  ForcastsResponse({
    required this.success,
    required this.result,
    required this.records,
  });
  factory ForcastsResponse.fromJson(Map<String, dynamic> json) =>
      _$ForcastsResponseFromJson(json);
}

@JsonSerializable()
class ForcastsRecord {
  final String datasetDescription;
  @JsonKey(name: "location")
  final List<Location> locations;

  ForcastsRecord({required this.datasetDescription, required this.locations});

  factory ForcastsRecord.fromJson(Map<String, dynamic> json) =>
      _$ForcastsRecordFromJson(json);
}

@JsonSerializable()
class Location {
  final String locationName;
  @JsonKey(name: "weatherElement")
  final List<WeatherElement> weatherElements;

  Location({required this.locationName, required this.weatherElements});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@JsonSerializable()
class WeatherElement {
  final String elementName;
  @JsonKey(name: "time")
  final List<TimeRange> timeRanges;

  WeatherElement({required this.elementName, required this.timeRanges});

  factory WeatherElement.fromJson(Map<String, dynamic> json) =>
      _$WeatherElementFromJson(json);
}

@JsonSerializable()
class TimeRange {
  final String startTime;
  final String endTime;
  final Parameter parameter;

  TimeRange({
    required this.startTime,
    required this.endTime,
    required this.parameter,
  });
  factory TimeRange.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeFromJson(json);
}

@JsonSerializable()
class Parameter {
  final String parameterName;
  final String? parameterValue;
  final String? parameterUnit;

  Parameter({
    required this.parameterName,
    this.parameterValue,
    this.parameterUnit,
  });
  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "resource_id")
  final String resourceId;
  Result({required this.resourceId});
  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

