/// {@template local_api}
/// Local API Connection
/// {@endtemplate}
abstract class ILocalApiRemote {
  /// Retorna la información del dispositivo Android
  Map<String, dynamic> getAndroidInfo();

  /// Retorna la información del dispositivo iOS
  Map<String, dynamic> getIosInfo();

  /// Retorna la información de la aplicación
  Map<String, dynamic> getPackageInfo();

  /// Retorna el lenguaje guardado
  String getLocale();

  /// Guarda el lenguaje
  Future<void> saveLocale({
    required String locale,
  });

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
