import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_api/user_api.dart';
import 'package:user_repository/user_repository.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit(this._userRepository, this._localRepository)
      : super(const PlansState());

  final UserRepository _userRepository;
  final LocalRepository _localRepository;

  Future<void> getPlans() async {
    emit(state.copyWith(status: PlansStatus.loading));
    try {
      final plans = await _userRepository.listPlans(
        sort: 'ASC',
        isActive: true,
      );
      final userOAuthToken = _localRepository.getUserOAuthToken();

      final androidInfo = _localRepository.getAndroidInfo();
      final iosInfo = _localRepository.getIosInfo();
      final packageInfo = _localRepository.getPackageInfo();

      emit(
        state.copyWith(
          status: PlansStatus.success,
          plans: plans,
          isUserLoggedIn: userOAuthToken != null,
          androidInfo: androidInfo,
          iosInfo: iosInfo,
          packageInfo: packageInfo,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PlansStatus.failure));
    }
  }

  void updateIsUserLoggedIn() {
    final userOAuthToken = _localRepository.getUserOAuthToken();
    final isUserLoggedIn = userOAuthToken != null;
    if (isUserLoggedIn != state.isUserLoggedIn) {
      emit(state.copyWith(isUserLoggedIn: userOAuthToken != null));
    }
  }
}
