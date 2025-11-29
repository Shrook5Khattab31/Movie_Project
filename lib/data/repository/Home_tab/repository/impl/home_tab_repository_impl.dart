import 'package:movie_project/Model/MoviesModel/MovieResponse.dart';
import '../../data_source/remote/home_remote_data_source.dart';
import '../home_tab_repository.dart';

class HomeTabRepositoryImpl implements HomeTabRepository{
HomeRemoteDataSource remoteDataSource;
HomeTabRepositoryImpl({required this.remoteDataSource});
  @override
  Future<MovieResponse> getAllMovies() {
    return remoteDataSource.getAllMovies();
  }
}