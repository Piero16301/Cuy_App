/// {@template local_api}
/// Local API Connection
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna el token de OAuth del sistema
  String? getSystemOAuthToken();

  /// Retorna el token de OAuth del usuario
  String? getUserOAuthToken();
}
