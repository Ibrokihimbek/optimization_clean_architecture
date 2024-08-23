part of "main_bloc.dart";

class MainState extends Equatable {
  const MainState({
    this.status = ApiStatus.initial,
    this.isForceUpdate,
  });

  final ApiStatus status;
  final bool? isForceUpdate;

  MainState copyWith({
    ApiStatus? status,
    bool? isForceUpdate,
  }) =>
      MainState(
        status: status ?? this.status,
        isForceUpdate: isForceUpdate ?? this.isForceUpdate,
      );

  @override
  List<Object?> get props => <Object?>[status, isForceUpdate];
}
