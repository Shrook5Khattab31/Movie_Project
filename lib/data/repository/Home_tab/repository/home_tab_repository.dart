import '../../../../Model/MoviesModel/MovieResponse.dart';
abstract class HomeTabRepository {
  Future<MovieResponse> getAllMovies();
}
