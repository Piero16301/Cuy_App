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

  /// Autenticación de sistema
  Future<void> authenticateSystem({
    required String user,
    required String password,
  }) async {
    return _userApiRemote.authenticateSystem(
      user: user,
      password: password,
    );
  }

  /// Autenticación de usuario
  Future<User> authenticateUser({
    required String user,
    required String password,
    required String systemOAuthToken,
  }) async {
    return _userApiRemote.authenticateUser(
      user: user,
      password: password,
      systemOAuthToken: systemOAuthToken,
    );
  }

  /// Listar planes
  Future<List<List<Plan>>> listPlans({
    required String sort,
    required bool isActive,
  }) async {
    return _userApiRemote.listPlans(
      sort: sort,
      isActive: isActive,
    );
  }
}
