import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_api/local_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template local_api_remote}
/// Local API Remote Connection
/// {@endtemplate}
class LocalApiRemote implements ILocalApiRemote {
  /// {@macro local_api_remote}
  const LocalApiRemote({
    required SharedPreferences preferences,
    required AndroidDeviceInfo androidInfo,
    required IosDeviceInfo iosInfo,
    required String deviceId,
  })  : _preferences = preferences,
        _androidInfo = androidInfo,
        _iosInfo = iosInfo,
        _deviceId = deviceId;

  final SharedPreferences _preferences;
  final AndroidDeviceInfo _androidInfo;
  final IosDeviceInfo _iosInfo;
  final String _deviceId;

  @override
  bool getIsAuthenticated() {
    return _preferences.getBool('__is_authenticated__') ?? false;
  }

  @override
  Future<void> setIsAuthenticated({required bool value}) async {
    await _preferences.setBool('__is_authenticated__', value);
  }

  @override
  Map<String, dynamic> getDeviceInfo() {
    return {
      'id': _deviceId,
      'version': Platform.isAndroid
          ? _androidInfo.version.release
          : _iosInfo.systemVersion ?? '-1',
      'model': Platform.isAndroid
          ? _androidInfo.model
          : _iosInfo.model ?? 'NO DISPONIBLE',
    };
  }

  @override
  Future<void> saveUserInfo({required Map<String, dynamic> user}) async {
    await _preferences.setString('__user__', jsonEncode(user));
  }

  @override
  Map<String, dynamic> getUserInfo() {
    return jsonDecode(_preferences.getString('__user__') ?? '{}')
        as Map<String, dynamic>;
  }

  @override
  Future<void> deleteUserInfo() async {
    await _preferences.remove('__user__');
  }
}
