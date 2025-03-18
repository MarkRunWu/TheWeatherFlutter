import 'package:dio/dio.dart';

sealed class AppError {}

class APIError extends AppError {
  final int statusCode;
  final String? message;

  APIError({required this.statusCode, this.message});

  factory APIError.from(DioException exception) {
    return APIError(
      statusCode: exception.response?.statusCode ?? 0,
      message: exception.message ?? exception.toString(),
    );
  }

  @override
  String toString() {
    return "[$statusCode]API Error($message)";
  }
}

class UnknownError extends AppError {}
