part of "main_bloc.dart";

class MainState extends Equatable {
  const MainState({
    this.status = ApiStatus.initial,
  });

  final ApiStatus status;

  MainState copyWith({
    ApiStatus? status,
    bool? isForceUpdate,
  }) =>
      MainState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => <Object?>[status];
}
