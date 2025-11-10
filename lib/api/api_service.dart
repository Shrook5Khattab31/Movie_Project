import 'package:dio/dio.dart';
import 'package:movie_project/api/api_constants.dart';
import 'package:movie_project/api/api_endpoints.dart';
class ApiService{
  var dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrlAuth
  ));


  void signIn({required String email, required String password}) async{
    var response = await dio.post(ApiEndPoints.login,
    data: {
      'email': "mai@gmail.com",
      'password': "123456780"
    }
    );
    print(response.statusCode);
    print(response.data.toString());
  }

}