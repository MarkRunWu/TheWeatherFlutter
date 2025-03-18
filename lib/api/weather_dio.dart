import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:the_weather_flutter/api/models/city.dart';
import 'package:the_weather_flutter/api/models/error.dart';
import 'package:the_weather_flutter/api/models/forcasts.dart';
import 'package:the_weather_flutter/api/weather.dart';
import 'package:the_weather_flutter/app_config.dart';

class DioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("Request ${options.uri}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("Response ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint("Request error ${err.toString()}");
    super.onError(err, handler);
  }
}

@Singleton(as: WeatherAPI)
class WeatherDio implements WeatherAPI {
  late Dio _dio;
  WeatherDio(AppConfig config) {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://opendata.cwa.gov.tw/api/v1/rest",
        queryParameters: {"Authorization": config.weatherApiKey},
      ),
    );
    _dio.interceptors.add(DioLogger());
  }

  Future<T> _requestJsonObj<T>(
    Future<Response<Map<String, dynamic>>> Function() apiCall,
    T Function(Map<String, dynamic>) decodeJson,
  ) async {
    try {
      final r = await apiCall();
      return decodeJson(r.data!);
    } catch (error) {
      if (error is DioException) {
        throw APIError.from(error);
      }
      rethrow;
    }
  }

  @override
  Future<ForcastsResponse> getForcasts36Hours(TaiwanCity city) {
    return _requestJsonObj(
      () => _dio.get(
        '/datastore/F-C0032-001',
        queryParameters: {"locationName": city.name, "sort": "time"},
      ),
      ForcastsResponse.fromJson,
    );
  }
}
