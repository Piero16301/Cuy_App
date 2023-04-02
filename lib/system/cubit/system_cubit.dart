import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'system_state.dart';

class SystemCubit extends Cubit<SystemState> {
  SystemCubit(this._localRepository, this._userRepository)
      : super(const SystemState());

  final LocalRepository _localRepository;
  final UserRepository _userRepository;

  Future<void> getSystemOAuthToken() async {
    emit(state.copyWith(status: SystemStatus.loading));
    try {
      final token = _localRepository.getSystemOAuthToken();
      if (token != null) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(status: SystemStatus.success));
      } else {
        await _userRepository.authenticateSystem(
          user: 'sys@cuy.pe',
          password: '123456',
        );
        emit(state.copyWith(status: SystemStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: SystemStatus.failure));
    }
  }
}
