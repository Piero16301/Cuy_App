import 'dart:io';

import 'package:cuy_app/app/app.dart';
import 'package:cuy_app/app/routes/routes.dart';
import 'package:cuy_app/bootstrap.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:local_api_remote/local_api_remote.dart';
import 'package:local_repository/local_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_api_remote/user_api_remote.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Almacenamiento local de preferencias de usuario
  final preferences = await SharedPreferences.getInstance();

  // Información del dispositivo
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  final iosInfo = await deviceInfo.iosInfo;
  final packageInfo = await PackageInfo.fromPlatform();

  // Cliente HTTP
  final httpClient = Dio(
    BaseOptions(
      baseUrl: 'https://apidev.cuy.pe',
      sendTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  // Inicializar lenguaje
  var locale = preferences.getString('__locale__');
  if (locale == null) {
    await preferences.setString(
      '__locale__',
      Platform.localeName.split('_')[0],
    );
    locale = Platform.localeName.split('_')[0];
  }

  // Inicializar Local API
  final localApiRemote = LocalApiRemote(
    preferences: preferences,
    androidInfo: androidInfo,
    iosInfo: iosInfo,
    packageInfo: packageInfo,
  );
  final localRepository = LocalRepository(
    localApiRemote: localApiRemote,
  );

  // Inicializar User API
  final userApiRemote = UserApiRemote(
    httpClient: httpClient,
    preferences: preferences,
  );
  final userRepository = UserRepository(
    userApiRemote: userApiRemote,
  );

  // Inicializar GoRouter
  final router = goRouter(localRepository);

  await bootstrap(
    () => AppPage(
      localRepository: localRepository,
      userRepository: userRepository,
      router: router,
      locale: locale!,
    ),
  );
}
