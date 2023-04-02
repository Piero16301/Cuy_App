import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_api/user_api.dart';
import 'package:user_repository/user_repository.dart';

part 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit(this._userRepository) : super(const PlansState());

  final UserRepository _userRepository;

  Future<void> getPlans() async {
    emit(state.copyWith(status: PlansStatus.loading));
    try {
      final plans = await _userRepository.listPlans(
        sort: 'ASC',
        isActive: true,
      );
      emit(
        state.copyWith(
          status: PlansStatus.success,
          plans: plans,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PlansStatus.failure));
    }
  }
}
