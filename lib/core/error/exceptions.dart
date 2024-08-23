import "package:flutter/foundation.dart";

@immutable
class ServerException implements Exception {
  const ServerException({required this.message});

  factory ServerException.fromJson(Map<String, dynamic> json) =>
      ServerException(message: json["detail"]);
  final String message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ServerException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

@immutable
class NoInternetException implements Exception {
  const NoInternetException();

  @override
  String toString() => "No Internet Connection";
}

@immutable
class CacheException implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is CacheException && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
