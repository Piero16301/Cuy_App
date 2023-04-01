/// {@template local_api}
/// Local API Connection
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna si está autenticado
  bool getIsAuthenticated();

  /// Establece si está autenticado
  Future<void> setIsAuthenticated({required bool value});

  /// Obtiene información del dispositivo
  Map<String, dynamic> getDeviceInfo();

  /// Guardar información del usuario
  Future<void> saveUserInfo({required Map<String, dynamic> user});

  /// Obtiene información del usuario
  Map<String, dynamic> getUserInfo();

  /// Elimina información del usuario
  Future<void> deleteUserInfo();
}
