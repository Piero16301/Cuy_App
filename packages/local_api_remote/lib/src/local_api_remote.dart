import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_api/local_api.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
    required PackageInfo packageInfo,
  })  : _preferences = preferences,
        _androidInfo = androidInfo,
        _iosInfo = iosInfo,
        _packageInfo = packageInfo;

  final SharedPreferences _preferences;
  final AndroidDeviceInfo _androidInfo;
  final IosDeviceInfo _iosInfo;
  final PackageInfo _packageInfo;

  @override
  Map<String, dynamic> getAndroidInfo() {
    return <String, dynamic>{
      'version.securityPatch': _androidInfo.version.securityPatch,
      'version.sdkInt': _androidInfo.version.sdkInt,
      'version.release': _androidInfo.version.release,
      'version.previewSdkInt': _androidInfo.version.previewSdkInt,
      'version.incremental': _androidInfo.version.incremental,
      'version.codename': _androidInfo.version.codename,
      'version.baseOS': _androidInfo.version.baseOS,
      'board': _androidInfo.board,
      'bootloader': _androidInfo.bootloader,
      'brand': _androidInfo.brand,
      'device': _androidInfo.device,
      'display': _androidInfo.display,
      'fingerprint': _androidInfo.fingerprint,
      'hardware': _androidInfo.hardware,
      'host': _androidInfo.host,
      'id': _androidInfo.id,
      'manufacturer': _androidInfo.manufacturer,
      'model': _androidInfo.model,
      'product': _androidInfo.product,
      'supported32BitAbis': _androidInfo.supported32BitAbis,
      'supported64BitAbis': _androidInfo.supported64BitAbis,
      'supportedAbis': _androidInfo.supportedAbis,
      'tags': _androidInfo.tags,
      'type': _androidInfo.type,
      'isPhysicalDevice': _androidInfo.isPhysicalDevice,
      'systemFeatures': _androidInfo.systemFeatures,
      'displaySizeInches':
          (_androidInfo.displayMetrics.sizeInches * 10).roundToDouble() / 10,
      'displayWidthPixels': _androidInfo.displayMetrics.widthPx,
      'displayWidthInches': _androidInfo.displayMetrics.widthInches,
      'displayHeightPixels': _androidInfo.displayMetrics.heightPx,
      'displayHeightInches': _androidInfo.displayMetrics.heightInches,
      'displayXDpi': _androidInfo.displayMetrics.xDpi,
      'displayYDpi': _androidInfo.displayMetrics.yDpi,
      'serialNumber': _androidInfo.serialNumber,
    };
  }

  @override
  Map<String, dynamic> getIosInfo() {
    return <String, dynamic>{
      'name': _iosInfo.name,
      'systemName': _iosInfo.systemName,
      'systemVersion': _iosInfo.systemVersion,
      'model': _iosInfo.model,
      'localizedModel': _iosInfo.localizedModel,
      'identifierForVendor': _iosInfo.identifierForVendor,
      'isPhysicalDevice': _iosInfo.isPhysicalDevice,
      'utsname.sysname:': _iosInfo.utsname.sysname,
      'utsname.nodename:': _iosInfo.utsname.nodename,
      'utsname.release:': _iosInfo.utsname.release,
      'utsname.version:': _iosInfo.utsname.version,
      'utsname.machine:': _iosInfo.utsname.machine,
    };
  }

  @override
  Map<String, dynamic> getPackageInfo() {
    return <String, dynamic>{
      'appName': _packageInfo.appName,
      'packageName': _packageInfo.packageName,
      'version': _packageInfo.version,
      'buildNumber': _packageInfo.buildNumber,
      'buildSignature': _packageInfo.buildSignature,
    };
  }

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
