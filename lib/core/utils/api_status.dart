part of "utils.dart";

enum ApiStatus {
  initial,
  loading,
  success,
  forceUpdate,
  promoSuccess,
  error;

  bool get isInitial => this == ApiStatus.initial;

  bool get isLoading => this == ApiStatus.loading;

  bool get isSuccess => this == ApiStatus.success;

  bool get isError => this == ApiStatus.error;

  bool get isForceUpdate => this == ApiStatus.forceUpdate;
}
