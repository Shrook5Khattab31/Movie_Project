import '../../../../../Model/MoviesModel/MovieResponse.dart';

abstract class HomeScreenRemoteDataSource{
  Future<MovieResponse> getAllMovies();
}