import 'package:dio/dio.dart';

sealed class AppError {}

class APIError extends AppError {
  final int statusCode;
  final String? message;

  APIError({required this.statusCode, this.message});

  factory APIError.from(DioException exception) {
    return APIError(
      statusCode: exception.response?.statusCode ?? 0,
      message: exception.response?.statusMessage,
    );
  }

  @override
  String toString() {
    return "[$statusCode]API Error($message)";
  }
}

class UnknownError extends AppError {}

extension LocalizedMessage on AppError {
  String get localizedMessage {
    return switch (this) {
      APIError(:final statusCode) =>
        (statusCode > 400 && statusCode < 500
            ? "權限錯誤($statusCode)，請檢查您的API KEY是否正確"
            : "伺服器錯誤"),
      UnknownError() => "無法辨識的錯誤",
    };
  }
}
