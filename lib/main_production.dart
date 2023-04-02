import 'package:cuy_app/app/app.dart';
import 'package:cuy_app/app/routes/routes.dart';
import 'package:cuy_app/bootstrap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:local_api_remote/local_api_remote.dart';
import 'package:local_repository/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_api_remote/user_api_remote.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Almacenamiento local de preferencias de usuario
  final preferences = await SharedPreferences.getInstance();

  // Cliente HTTP
  final httpClient = Dio(
    BaseOptions(
      baseUrl: 'https://apidev.cuy.pe',
      sendTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  // Inicializar Local API
  final localApiRemote = LocalApiRemote(
    preferences: preferences,
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
    ),
  );
}
