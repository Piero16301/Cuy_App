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
