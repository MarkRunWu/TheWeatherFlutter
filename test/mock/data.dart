import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';

Location createMockLocationResponse(TaiwanCity city) {
  final baseLocation = Location.fromJson(mockLocationResponse);

  return Location(
    weatherElements: baseLocation.weatherElements,
    locationName: city.name,
  );
}

ForcastsResponse createMockForcastsResponse(List<TaiwanCity> cities) {
  final baseResponse = mockForcastsResponse;
  return ForcastsResponse(
    success: baseResponse.success,
    result: baseResponse.result,
    records: ForcastsRecord(
      datasetDescription: baseResponse.records.datasetDescription,

      locations:
          cities.map((city) => createMockLocationResponse(city)).toList(),
    ),
  );
}

final mockForcastsResponse = ForcastsResponse.fromJson({
  "success": "true",
  "result": {
    "resource_id": "F-C0032-001",
    "fields": [
      {"id": "datasetDescription", "type": "String"},
      {"id": "locationName", "type": "String"},
      {"id": "parameterName", "type": "String"},
      {"id": "parameterValue", "type": "String"},
      {"id": "parameterUnit", "type": "String"},
      {"id": "startTime", "type": "Timestamp"},
      {"id": "endTime", "type": "Timestamp"},
    ],
  },
  "records": {
    "datasetDescription": "三十六小時天氣預報",
    "location": [mockLocationResponse],
  },
});

final mockLocationResponse = {
  "locationName": "宜蘭縣",
  "weatherElement": [
    {
      "elementName": "Wx",
      "time": [
        {
          "startTime": "2025-03-19 18:00:00",
          "endTime": "2025-03-20 06:00:00",
          "parameter": {"parameterName": "陰天", "parameterValue": "7"},
        },
        {
          "startTime": "2025-03-20 06:00:00",
          "endTime": "2025-03-20 18:00:00",
          "parameter": {"parameterName": "陰天", "parameterValue": "7"},
        },
        {
          "startTime": "2025-03-20 18:00:00",
          "endTime": "2025-03-21 06:00:00",
          "parameter": {"parameterName": "晴時多雲", "parameterValue": "2"},
        },
      ],
    },
    {
      "elementName": "PoP",
      "time": [
        {
          "startTime": "2025-03-19 18:00:00",
          "endTime": "2025-03-20 06:00:00",
          "parameter": {"parameterName": "20", "parameterUnit": "百分比"},
        },
        {
          "startTime": "2025-03-20 06:00:00",
          "endTime": "2025-03-20 18:00:00",
          "parameter": {"parameterName": "10", "parameterUnit": "百分比"},
        },
        {
          "startTime": "2025-03-20 18:00:00",
          "endTime": "2025-03-21 06:00:00",
          "parameter": {"parameterName": "0", "parameterUnit": "百分比"},
        },
      ],
    },
    {
      "elementName": "MinT",
      "time": [
        {
          "startTime": "2025-03-19 18:00:00",
          "endTime": "2025-03-20 06:00:00",
          "parameter": {"parameterName": "11", "parameterUnit": "C"},
        },
        {
          "startTime": "2025-03-20 06:00:00",
          "endTime": "2025-03-20 18:00:00",
          "parameter": {"parameterName": "11", "parameterUnit": "C"},
        },
        {
          "startTime": "2025-03-20 18:00:00",
          "endTime": "2025-03-21 06:00:00",
          "parameter": {"parameterName": "10", "parameterUnit": "C"},
        },
      ],
    },
    {
      "elementName": "CI",
      "time": [
        {
          "startTime": "2025-03-19 18:00:00",
          "endTime": "2025-03-20 06:00:00",
          "parameter": {"parameterName": "寒冷"},
        },
        {
          "startTime": "2025-03-20 06:00:00",
          "endTime": "2025-03-20 18:00:00",
          "parameter": {"parameterName": "寒冷至稍有寒意"},
        },
        {
          "startTime": "2025-03-20 18:00:00",
          "endTime": "2025-03-21 06:00:00",
          "parameter": {"parameterName": "非常寒冷至寒冷"},
        },
      ],
    },
    {
      "elementName": "MaxT",
      "time": [
        {
          "startTime": "2025-03-19 18:00:00",
          "endTime": "2025-03-20 06:00:00",
          "parameter": {"parameterName": "13", "parameterUnit": "C"},
        },
        {
          "startTime": "2025-03-20 06:00:00",
          "endTime": "2025-03-20 18:00:00",
          "parameter": {"parameterName": "18", "parameterUnit": "C"},
        },
        {
          "startTime": "2025-03-20 18:00:00",
          "endTime": "2025-03-21 06:00:00",
          "parameter": {"parameterName": "15", "parameterUnit": "C"},
        },
      ],
    },
  ],
};
