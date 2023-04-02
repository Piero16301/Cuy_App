/// {@template local_api}
/// Local API Connection
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna el token de OAuth del sistema
  String? getSystemOAuthToken();

  /// Retorna el token de OAuth del usuario
  String? getUserOAuthToken();

  /// Eliminar el token de OAuth del usuario
  Future<void> removeUserOAuthToken();

  /// Guarda detalles del usuario
  Future<void> saveUserDetails({
    required Map<String, dynamic> user,
  });

  /// Obtiene detalles del usuario
  Map<String, dynamic> getUserDetails();

  /// Elimina detalles del usuario
  Future<void> removeUserDetails();
}
