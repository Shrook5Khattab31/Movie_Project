import 'package:dio/dio.dart';
import 'package:movie_project/Model/MovieResponse.dart';
import 'package:movie_project/api/api_constants.dart';
import 'package:movie_project/api/api_endpoints.dart';

import '../Model/details.dart';

class ApiService {
  var dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrlAuth,
  ));
  static var movieDio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrlMovies,
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

  // GET profile
  Future<Map<String, dynamic>> getProfile(String token) async {
    final response = await dio.get(
      'profile',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    if (response.statusCode == 200 && response.data is Map) {
      return Map<String, dynamic>.from(response.data['data']);
    } else {
      throw Exception(response.data?['message'] ?? 'Failed to load profile');
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
          'avaterId': avatarId,
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
  // Future<Response> resetPassword({
  //   required String oldPassword,
  //   required String newPassword,
  //   required String token,
  // }) async {
  //   try {
  //     var response = await dio.patch(
  //       ApiEndPoints.reset_password,
  //       data: {
  //         'oldPassword': oldPassword,
  //         'newPassword': newPassword,
  //       },
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //         validateStatus: (status) => status! < 500,
  //       ),
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //homeTab
  static Future<MovieResponse> getAllMovies({int page = 1,int limit = 20,String? genre,}) async {
    try {
      var response = await movieDio.get(
        ApiEndPoints.listMovies,
        queryParameters: {
          'limit': limit,
          'page': page,
          if (genre != null) 'genre': genre,
        },
      );
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token
}) async{
    try{
      var response = await dio.patch(ApiEndPoints.reset_password,
      data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword
      },
        options: Options(
          headers: {
            'Authorization':'Bearer $token'
          }
        )
      );
      return response;

    }
    catch(e){
      rethrow;

    }
    }
  static Future<Movie> fetchMovie(int ?movieId) async {
    try {
      final response = await movieDio.get(ApiEndPoints.movieDetails,
        queryParameters: {
          'movie_id': movieId,
          'with_images': true,
          'with_cast': true,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data['data']['movie'];
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to load movie');
      }
    } catch (e) {
      throw Exception('Failed to load movie: $e');
    }
  }

}