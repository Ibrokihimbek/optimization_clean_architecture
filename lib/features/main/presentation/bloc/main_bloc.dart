import "dart:io";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pizza_hut_client_mobile/constants/constants.dart";
import "package:pizza_hut_client_mobile/core/either/either.dart";
import "package:pizza_hut_client_mobile/core/error/failure.dart";
import "package:pizza_hut_client_mobile/core/extension/extension.dart";
import "package:pizza_hut_client_mobile/core/utils/utils.dart";
import "package:pizza_hut_client_mobile/features/main/data/models/update_version_response.dart";
import "package:pizza_hut_client_mobile/features/main/domain/repository/main_repository.dart";
import "package:pizza_hut_client_mobile/injector_container.dart";

part "main_state.dart";

part "main_event.dart";

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc({
    required this.repository,
  }) : super(const MainState()) {
    on<MainAppVersionCheck>(_onMainAppVersion);
  }

  final MainRepository repository;

  Future<void> _onMainAppVersion(
    MainAppVersionCheck event,
    Emitter<MainState> emit,
  ) async {
    emit(state.copyWith(status: ApiStatus.initial));
    final Either<Failure, UpdateVersionResponse> result =
        await repository.getAppVersion(appName: Constants.appName);
    result.fold(
      (Failure l) {
        emit(state.copyWith(status: ApiStatus.error));
      },
      (UpdateVersionResponse r) {
        /// Getting current version of the app.
        final int currentVersion = packageInfo.version.toVersion;

        /// Using default duration to force fetching from remote server.
        final int androidVersion = (r.androidVersion ?? "").toVersion;
        final int iosVersion = (r.iosVersion ?? "").toVersion;
        final int appVersion = Platform.isIOS ? iosVersion : androidVersion;
        if (appVersion > currentVersion) {
          emit(
            state.copyWith(
              status: ApiStatus.forceUpdate,
              isForceUpdate: r.isForce ?? false,
            ),
          );
        }
        emit(state.copyWith(status: ApiStatus.initial));
      },
    );
  }
}
