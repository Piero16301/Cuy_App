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

  /// Retorna si está autenticado
  bool getIsAuthenticated() {
    return _apiRemote.getIsAuthenticated();
  }

  /// Establece si está autenticado
  Future<void> setIsAuthenticated({required bool value}) async {
    await _apiRemote.setIsAuthenticated(value: value);
  }

  /// Obtiene información del dispositivo
  Map<String, dynamic> getDeviceInfo() {
    return _apiRemote.getDeviceInfo();
  }

  /// Guardar información del usuario
  Future<void> saveUserInfo({required Map<String, dynamic> user}) async {
    await _apiRemote.saveUserInfo(user: user);
  }

  /// Obtiene información del usuario
  Map<String, dynamic> getUserInfo() {
    return _apiRemote.getUserInfo();
  }

  /// Elimina información del usuario
  Future<void> deleteUserInfo() async {
    await _apiRemote.deleteUserInfo();
  }
}
