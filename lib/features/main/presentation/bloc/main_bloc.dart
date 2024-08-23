
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:currency_clean_architecture/core/utils/utils.dart";

part "main_state.dart";

part "main_event.dart";

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState());
}
