import 'dart:convert';

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

  @override
  Future<void> removeUserOAuthToken() async {
    await _preferences.remove('__user_oauth_token__');
  }

  @override
  Future<void> saveUserDetails({required Map<String, dynamic> user}) async {
    await _preferences.setString('__user_details__', jsonEncode(user));
  }

  @override
  Map<String, dynamic> getUserDetails() {
    return jsonDecode(_preferences.getString('__user_details__') ?? '{}')
        as Map<String, dynamic>;
  }

  @override
  Future<void> removeUserDetails() async {
    await _preferences.remove('__user_details__');
  }
}
