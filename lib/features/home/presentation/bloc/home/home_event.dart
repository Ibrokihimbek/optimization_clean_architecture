part of "home_bloc.dart";

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchCurrencyEvent extends HomeEvent {
  const FetchCurrencyEvent();

  @override
  List<Object?> get props => [];
}

