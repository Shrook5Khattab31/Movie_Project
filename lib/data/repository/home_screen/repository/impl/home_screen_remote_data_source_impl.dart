import 'package:movie_project/Model/MoviesModel/MovieResponse.dart';
import 'package:movie_project/api/api_service.dart';

import '../../datasource/remote/home_screen_remote_data_source.dart';
class HomeScreenRemoteDataSourceImpl implements HomeScreenRemoteDataSource{
  ApiService apiService;
  HomeScreenRemoteDataSourceImpl  ({required this.apiService});
  @override
  Future<MovieResponse> getAllMovies() {
    var  homeScreenResponse = ApiService.getAllMovies();
    return homeScreenResponse;
  }
}