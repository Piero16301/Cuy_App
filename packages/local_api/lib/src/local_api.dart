/// {@template local_api}
/// Local API Connection
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna si está autenticado
  bool getIsAuthenticated();

  /// Establece si está autenticado
  Future<void> setIsAuthenticated({required bool value});
}
