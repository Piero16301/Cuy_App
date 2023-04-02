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
}
