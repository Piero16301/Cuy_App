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
}
