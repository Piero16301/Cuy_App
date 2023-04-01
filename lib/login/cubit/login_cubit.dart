import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_repository/local_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._localRepository, this._userRepository)
      : super(const LoginState());

  final LocalRepository _localRepository;
  final UserRepository _userRepository;

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void userChanged(String user) {
    emit(state.copyWith(user: user));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> login() async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await Future<void>.delayed(const Duration(seconds: 2));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  }
}
