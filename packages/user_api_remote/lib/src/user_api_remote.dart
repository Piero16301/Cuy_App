import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:user_api/user_api.dart';

/// {@template user_api_remote}
/// User API Remote Connection
/// {@endtemplate}
class UserApiRemote implements IUserApiRemote {
  /// {@macro user_api_remote}
  const UserApiRemote({
    required Dio httpClient,
  }) : _httpClient = httpClient;

  final Dio _httpClient;

  @override
  Future<User> getUserFromDevice({
    required String deviceId,
  }) async {
    try {
      // final response = await _httpClient.post<Map<String, dynamic>>(
      //   'https://jsonplaceholder.typicode.com/users/1',
      //   data: {
      //     'deviceId': deviceId,
      //   },
      // );

      // if (response.statusCode != 200) throw Exception();
      // if (response.data == null) throw Exception();

      // final userJson = response.data?['data'] as Map<String, dynamic>;
      // final userModel = User.fromJson(userJson);

      await Future<void>.delayed(const Duration(seconds: 2));

      const userModel = User(
        userId: '1',
        username: 'piero',
        email: 'piero.morales@utec.edu.pe',
        name: 'Piero',
        lastName: 'Morales',
        password: 'asdasd',
      );

      return userModel;
    } on DioError catch (e) {
      debugPrint('Dio error: ${e.message}');
      throw Exception(e);
    } catch (e) {
      debugPrint('Error: $e');
      throw Exception(e);
    }
  }
}
