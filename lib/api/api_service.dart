import 'package:dio/dio.dart';
import 'package:movie_project/api/api_constants.dart';
import 'package:movie_project/api/api_endpoints.dart';
class ApiService {
  var dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrlAuth
  ));


  void signIn({required String email, required String password}) async {
    var response = await dio.post(ApiEndPoints.login,
        data: {
          'email': "mai@gmail.com",
          'password': "123456780"
        }
    );
    print(response.statusCode);
    print(response.data.toString());
  }

  Future<Response> registerUser({required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avaterId,
  }) async {
    try {
      var response = await dio.post(ApiEndPoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          'phone': phone,
          'avaterId': avaterId
        },
        options: Options(
          validateStatus: (status) => status! < 500,
        ),
      );
      return response;
    }
    catch (e) {
      rethrow;
    }
  }
}