part of "main_bloc.dart";

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class MainAppVersionCheck extends MainEvent {
  const MainAppVersionCheck();

  @override
  List<Object?> get props => <Object?>[];
}
