import '../../../../Model/MoviesModel/MovieResponse.dart';
abstract class HomeScreenRepository {
  Future<MovieResponse> getAllMovies();
}
