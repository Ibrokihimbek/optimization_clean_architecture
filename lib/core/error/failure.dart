import "package:equatable/equatable.dart";

sealed class Failure extends Equatable {
  const Failure({
    this.statusCode,
    required this.message,
  });

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => <Object?>[message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.statusCode,
  });

  @override
  List<Object?> get props => <Object?>[message, statusCode];
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({required super.message});

  @override
  List<Object?> get props => <Object?>[];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  @override
  List<Object?> get props => <Object?>[message];
}
