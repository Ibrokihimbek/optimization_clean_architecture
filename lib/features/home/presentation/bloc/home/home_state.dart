part of "home_bloc.dart";

class HomeState extends Equatable {
  const HomeState({
    this.currency = const <CurrencyResponseModel>[],
    this.apiStatus = ApiStatus.initial,
  });

  final List<CurrencyResponseModel> currency;
  final ApiStatus apiStatus;

  HomeState copyWith({
    List<CurrencyResponseModel>? currency,
    ApiStatus? apiStatus,
  }) {
    return HomeState(
      currency: currency ?? this.currency,
      apiStatus: apiStatus ?? this.apiStatus,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currency,
        apiStatus,
      ];
}
