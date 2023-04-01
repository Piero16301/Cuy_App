import 'package:user_api/user_api.dart';

/// {@template user_repository}
/// User Repository Connection
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({
    required IUserApiRemote userApiRemote,
  }) : _userApiRemote = userApiRemote;

  final IUserApiRemote _userApiRemote;

  /// Login de usuario
  Future<User> getUserFromDevice({
    required String deviceId,
  }) async {
    return _userApiRemote.getUserFromDevice(
      deviceId: deviceId,
    );
  }
}
