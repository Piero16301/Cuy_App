part of 'login_cubit.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isFailure => this == LoginStatus.failure;
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.formKey,
    this.user = '',
    this.password = '',
    this.isPasswordVisible = false,
  });

  final LoginStatus status;
  final GlobalKey<FormState>? formKey;
  final String user;
  final String password;
  final bool isPasswordVisible;

  LoginState copyWith({
    LoginStatus? status,
    GlobalKey<FormState>? formKey,
    String? user,
    String? password,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      status: status ?? this.status,
      formKey: formKey ?? this.formKey,
      user: user ?? this.user,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }

  @override
  List<Object?> get props => [
        status,
        formKey,
        user,
        password,
        isPasswordVisible,
      ];
}
