part of 'user_cubit.dart';

enum UserStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == UserStatus.initial;
  bool get isLoading => this == UserStatus.loading;
  bool get isSuccess => this == UserStatus.success;
  bool get isFailure => this == UserStatus.failure;
}

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.initial,
    this.user,
    this.backToPlans = false,
  });

  final UserStatus status;
  final User? user;
  final bool backToPlans;

  UserState copyWith({
    UserStatus? status,
    User? user,
    bool? backToPlans,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      backToPlans: backToPlans ?? this.backToPlans,
    );
  }

  @override
  List<Object?> get props => [
        status,
        user,
        backToPlans,
      ];
}
