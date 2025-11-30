import 'package:movie_project/Model/MoviesModel/MovieResponse.dart';
import 'package:movie_project/api/api_service.dart';

import '../../data_source/remote/home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource{
  ApiService apiService;
  HomeRemoteDataSourceImpl ({required this.apiService});
  @override
  Future<MovieResponse> getAllMovies() {
    var homeTabResponse = ApiService.getAllMovies();
    return homeTabResponse;
  }
}