import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_api/user_api.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._localRepository) : super(const UserState());

  final LocalRepository _localRepository;

  void loadUserDetails() {
    try {
      final user = User.fromJson(_localRepository.getUserDetails());
      emit(state.copyWith(user: user));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      await _localRepository.removeUserOAuthToken();
      await _localRepository.removeUserDetails();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(backToPlans: true, status: UserStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure));
      debugPrint(e.toString());
    }
  }
}
