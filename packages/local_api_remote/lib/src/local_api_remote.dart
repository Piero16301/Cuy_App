import 'package:local_api/local_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_api_remote}
/// Local API Remote Connection
/// {@endtemplate}
class LocalApiRemote implements ILocalApiRemote {
  /// {@macro local_api_remote}
  const LocalApiRemote({
    required SharedPreferences preferences,
  }) : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  bool getIsAuthenticated() {
    return _preferences.getBool('__is_authenticated__') ?? false;
  }

  @override
  Future<void> setIsAuthenticated({required bool value}) async {
    await _preferences.setBool('__is_authenticated__', value);
  }
}
