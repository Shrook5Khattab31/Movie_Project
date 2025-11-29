import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/Model/MoviesModel/MovieResponse.dart';
import 'package:movie_project/api/api_constants.dart';
import 'package:movie_project/api/api_endpoints.dart';

import '../Model/MovieDetailsModel/details.dart';
import '../Model/MoviesModel/Movies.dart';
import '../Model/favorites/favorite.dart';

class ApiService {
  static var dio = Dio(BaseOptions(
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
      ApiEndPoints.profile,
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
        ApiEndPoints.profile,
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

  //Delete Account
  Future<String?> deleteAccount({required String token}) async {
    try {
      var response = await dio.delete(
        ApiEndPoints.profile,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      debugPrint("Status: ${response.statusCode}");
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200) {
        return response.data["message"];
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Delete Error: $e");
      rethrow;
    }
  }

  //homeTab
  static Future<MovieResponse> getAllMovies({int page =3500,int limit = 20,String? genre,}) async {
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
      var response = await dio.patch(ApiEndPoints.resetPassword,
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
    } catch (e) {
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

  static Future<List<Movies>> getSimilarMovies(int? movieId) async {
    try {
      final response = await movieDio.get(
        ApiEndPoints.movieSuggestions,
        queryParameters: {"movie_id": movieId},
      );
      final moviesJson = response.data['data']['movies'] as List?;
      if (moviesJson == null) return [];

      return moviesJson.map((m) => Movies.fromJson(m)).toList();
    } catch (e) {
      return [];
    }
  }
  static Future<List<Favorite>> getAllFavoritesMovies({required String token}) async {
    try {
      final response = await dio.get(
        ApiEndPoints.allFavorites,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      final moviesJson = response.data['data'] as List?;
      if (moviesJson == null) return [];
      return moviesJson.map((json) => Favorite.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<bool?> checkMovieIsFav({
    required int? movieId,
    required String token,
  }) async {
    try {
      final response = await dio.get(
        'favorites/is-favorite/$movieId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data'] as bool;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addFavorite({
    required Movies movie,
    required String token, int? movieId,
  }) async {
    try {
       await dio.post(
        ApiEndPoints.favorites,
        data: {
          'movieId': movie.id,
          'name': movie.title ?? '',
          'rating': movie.rating ?? 0,
          'imageURL': movie.mediumCoverImage ?? '',
          'year': movie.year ?? 0,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      return;
    }
  }

  static Future<void> removeFavorite({required int? movieId, required String token}) async {
    await dio.delete(
      'favorites/remove/$movieId',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  static Future<List<Movies>> searchMovies(String title) async {
    try{
      final response = await movieDio.get(
        ApiEndPoints.searchMovie,
        queryParameters: {
          "query_term": title,
        },
      );
      final data = response.data["data"]["movies"] as List?;
      if (data == null) return [];
      return data.map((m) => Movies.fromJson(m)).toList();
    }catch(e){
      rethrow;
    }
  }

}
