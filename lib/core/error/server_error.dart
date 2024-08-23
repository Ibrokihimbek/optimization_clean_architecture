// ignore_for_file: avoid_dynamic_calls
import "package:dio/dio.dart" hide Headers;
import "package:pizza_hut_client_mobile/core/error/failure.dart";

final class ServerError implements Exception {
  ServerError.withDioError({required DioException error}) {
    _handleError(error);
  }

  ServerError.withError({
    required Response<dynamic> error,
    int? code,
  }) {
    _errorCode = error.statusCode ?? 500;
    if (_errorCode == 403 || _errorCode == 401) {
      _errorMessage = "Token expired";
      return;
    }
    if (_errorCode == 500 || _errorCode == 503 || _errorCode == 502) {
      _errorMessage = "Server error";
      return;
    }
    if (_errorCode == 404) {
      if (error.data is Map) {
        final Map<String, dynamic> data = error.data ?? <String, dynamic>{};
        _errorMessage = data["Error"]["message"];
        return;
      }
      _errorMessage = "Not Found";
      return;
    }
    if (_errorCode == 413) {
      _errorMessage = "Request Entity Too Large";
      return;
    }
    if (error.data is String) {
      _errorMessage = error.data;
      return;
    } else if (error.data is Map<String, dynamic>) {
      final Map<String, dynamic> data = error.data ?? "";
      if (data["Error"] is String) {
        _errorMessage = data["Error"] ?? "";
      } else if (data["Error"] is Map<String, dynamic>) {
        final Map<String, dynamic> errorData = data["Error"];
        _errorMessage = errorData["message"] ?? "";
      } else if (data["message"] is String) {
        _errorMessage = data["message"];
      } else {
        _errorMessage = "Something wrong";
      }
    } else {
      _errorMessage = "Something wrong";
    }
    _errorCode = code;
  }

  ServerError.withException({required Exception error}) {
    _errorCode = 0;
    _errorMessage = error.toString();
  }

  ServerError.withErrorMessage({required String error}) {
    _errorCode = 0;
    _errorMessage = error;
  }

  int? _errorCode;
  String _errorMessage = "";

  int get errorCode => _errorCode ?? 0;

  String get message => _errorMessage;

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        _errorMessage = "Connection error";
      case DioExceptionType.connectionTimeout:
        _errorMessage = "Connection timeout";
      case DioExceptionType.sendTimeout:
        _errorMessage = "Send timeout";
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Receive timeout";
      case DioExceptionType.badResponse:
        {
          _errorCode = error.response?.statusCode ?? 500;
          if (_errorCode == 403 || _errorCode == 401) {
            _errorMessage = "Token expired";
            return;
          }
          if (_errorCode == 500 || _errorCode == 503 || _errorCode == 502) {
            _errorMessage = "Server error";
            return;
          }
          if (_errorCode == 404) {
            if (error.response?.data is Map) {
              final Map<String, dynamic> data =
                  error.response?.data ?? <String, dynamic>{};
              _errorMessage = data["Error"]["message"];
              return;
            }
            _errorMessage = "Not Found";
            return;
          }
          if (_errorCode == 413) {
            _errorMessage = "Request Entity Too Large";
            return;
          }
          if (error.response?.data is String) {
            _errorMessage = error.response!.data;
            return;
          } else if (error.response?.data is Map<String, dynamic>) {
            final Map<String, dynamic> data = error.response?.data ?? "";
            if (data["Error"] is String) {
              _errorMessage = data["Error"] ?? "";
            } else if (data["Error"] is Map<String, dynamic>) {
              final Map<String, dynamic> errorData = data["Error"];
              _errorMessage = errorData["message"] ?? "";
            } else if (data["message"] is String) {
              _errorMessage = data["message"];
            } else {
              _errorMessage = "Something wrong";
            }
          } else {
            _errorMessage = "Something wrong";
          }
          break;
        }
      case DioExceptionType.cancel:
        _errorMessage = "Canceled";
      case DioExceptionType.unknown:
        _errorMessage = "Something wrong";
      case DioExceptionType.badCertificate:
        _errorMessage = "Bad certificate";
    }
    return;
  }
}

extension ServerErrorExtension on ServerError {
  bool get isTokenExpired => errorCode == 401;

  ServerFailure get failure => ServerFailure(
        message: message,
        statusCode: errorCode,
      );
}
