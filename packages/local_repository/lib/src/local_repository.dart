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

  /// Retorna la información del dispositivo Android
  Map<String, dynamic> getAndroidInfo() {
    return _apiRemote.getAndroidInfo();
  }

  /// Retorna la información del dispositivo iOS
  Map<String, dynamic> getIosInfo() {
    return _apiRemote.getIosInfo();
  }

  /// Retorna la información de la aplicación
  Map<String, dynamic> getPackageInfo() {
    return _apiRemote.getPackageInfo();
  }

  /// Retorna el lenguaje guardado
  String getLocale() {
    return _apiRemote.getLocale();
  }

  /// Guarda el lenguaje
  Future<void> saveLocale({
    required String locale,
  }) async {
    await _apiRemote.saveLocale(locale: locale);
  }

  /// Retorna el token de OAuth del sistema
  String? getSystemOAuthToken() {
    return _apiRemote.getSystemOAuthToken();
  }

  /// Retorna el token de OAuth del usuario
  String? getUserOAuthToken() {
    return _apiRemote.getUserOAuthToken();
  }

  /// Eliminar el token de OAuth del usuario
  Future<void> removeUserOAuthToken() async {
    await _apiRemote.removeUserOAuthToken();
  }

  /// Guarda detalles del usuario
  Future<void> saveUserDetails({
    required Map<String, dynamic> user,
  }) async {
    await _apiRemote.saveUserDetails(user: user);
  }

  /// Obtiene detalles del usuario
  Map<String, dynamic> getUserDetails() {
    return _apiRemote.getUserDetails();
  }

  /// Elimina detalles del usuario
  Future<void> removeUserDetails() async {
    await _apiRemote.removeUserDetails();
  }
}
