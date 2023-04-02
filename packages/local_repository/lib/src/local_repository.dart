import 'package:local_api/local_api.dart';

/// {@template local_repository}
/// Local Repository Connection
/// {@endtemplate}
class LocalRepository {
  /// {@macro local_repository}
  const LocalRepository({
    required ILocalApiRemote localApiRemote,
  }) : _apiRemote = localApiRemote;

  final ILocalApiRemote _apiRemote;

  /// Retorna el token de OAuth del sistema
  String? getSystemOAuthToken() {
    return _apiRemote.getSystemOAuthToken();
  }

  /// Retorna el token de OAuth del usuario
  String? getUserOAuthToken() {
    return _apiRemote.getUserOAuthToken();
  }
}
