import 'package:user_api/user_api.dart';

/// {@template user_api}
/// User API Connection
/// {@endtemplate}
abstract class IUserApiRemote {
  /// Obtiene el usuario vinculado al dispositivo
  Future<User> getUserFromDevice({
    required String deviceId,
  });
}
