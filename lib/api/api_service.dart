import 'package:dio/dio.dart';
import 'package:movie_project/api/api_constants.dart';
import 'package:movie_project/api/api_endpoints.dart';

class ApiService {
  var dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrlAuth,
  ));

  // Login
  Future<Response> signIn({required String email, required String password}) async {
    try {
      var response = await dio.post(
        ApiEndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  // Register
  Future<Response> registerUser({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    try {
      var response = await dio.post(
        ApiEndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'phone': phone,
          'avaterId': avaterId,
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Update Profile
  Future<Response> updateProfile({
    required String email,
    required int avatarId,
    required String token,
  }) async {
    try {
      var response = await dio.patch(
        ApiEndPoints.updateProfile,
        data: {
          'email': email,
          'avatarId': avatarId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! < 500,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Reset Password
  Future<Response> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    try {
      var response = await dio.patch(
        ApiEndPoints.reset_password,
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) => status! < 500,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}