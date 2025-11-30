import '../../../../../Model/MoviesModel/MovieResponse.dart';

abstract class HomeRemoteDataSource{
  Future<MovieResponse>  getAllMovies();
}