import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_api/user_api.dart';

/// {@template user_api_remote}
/// User API Remote Connection
/// {@endtemplate}
class UserApiRemote implements IUserApiRemote {
  /// {@macro user_api_remote}
  const UserApiRemote({
    required Dio httpClient,
    required SharedPreferences preferences,
  })  : _httpClient = httpClient,
        _preferences = preferences;

  final Dio _httpClient;
  final SharedPreferences _preferences;

  @override
  Future<void> authenticateSystem({
    required String user,
    required String password,
  }) async {
    try {
      final response = await _httpClient.post<Map<String, dynamic>>(
        '/api/v1/auth',
        data: {
          'email': user,
          'password': password,
        },
      );

      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();

      final oauthToken = response.data!['oauthToken'] as String?;
      if (oauthToken == null) throw Exception();

      // Guardar el token en las preferencias
      await _preferences.setString('__system_oauth_token__', oauthToken);
    } on DioError catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception(e);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  @override
  Future<User> authenticateUser({
    required String user,
    required String password,
    required String systemOAuthToken,
  }) async {
    try {
      final response = await _httpClient.post<Map<String, dynamic>>(
        '/api/v1/user/login',
        data: {
          'emailOrPhone': user,
          'password': password,
        },
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Cuy-oauthtoken $systemOAuthToken',
          },
        ),
      );

      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();

      final userJson = response.data?['data'] as Map<String, dynamic>;
      final userModel = User.fromJson(userJson);

      final userOauthToken = response.data?['oauthToken'] as String?;
      if (userOauthToken == null) throw Exception();

      // Guardar el token en las preferencias
      await _preferences.setString('__user_oauth_token__', userOauthToken);

      return userModel;
    } on DioError catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception(e);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }

  @override
  Future<List<List<Plan>>> listPlans({
    required String sort,
    required bool isActive,
  }) async {
    try {
      final systemOauthToken =
          _preferences.getString('__system_oauth_token__') ?? '';
      final response = await _httpClient.get<Map<String, dynamic>>(
        '/api/v1/service-package',
        queryParameters: <String, dynamic>{
          'sort': sort,
          'isActive': isActive,
        },
        options: Options(
          headers: <String, dynamic>{
            'Authorization': 'Cuy-oauthtoken $systemOauthToken',
          },
        ),
      );

      if (response.statusCode != 200) throw Exception();
      if (response.data == null) throw Exception();

      final planListJson = response.data?['list'] as List<dynamic>;
      final planList = planListJson
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList();

      final planListFreeJson = response.data?['appListFree'] as List<dynamic>;
      final planListFree = planListFreeJson
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList();

      return [planList, planListFree];
    } on DioError catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception(e);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}
