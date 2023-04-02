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
  String? getSystemOAuthToken() {
    return _preferences.getString('__system_oauth_token__');
  }

  @override
  String? getUserOAuthToken() {
    return _preferences.getString('__user_oauth_token__');
  }
}
