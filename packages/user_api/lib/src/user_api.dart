import 'package:user_api/user_api.dart';

/// {@template user_api}
/// User API Connection
/// {@endtemplate}
abstract class IUserApiRemote {
  /// Autenticación de sistema
  Future<void> authenticateSystem({
    required String user,
    required String password,
  });

  /// Autenticación de usuario
  Future<User> authenticateUser({
    required String user,
    required String password,
    required String systemOAuthToken,
  });

  /// Listar planes de usuario
  Future<List<List<Plan>>> listPlans({
    required String sort,
    required bool isActive,
  });
}
