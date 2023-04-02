part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
  });

  final User? user;

  UserState copyWith({
    User? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
