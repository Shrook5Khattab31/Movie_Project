import 'package:movie_project/Model/MoviesModel/MovieResponse.dart';
import '../../datasource/remote/home_screen_remote_data_source.dart';
import '../home_tab_repository.dart';

class HomeScreenRepositoryImpl implements HomeScreenRepository{
HomeScreenRemoteDataSource remoteDataSource;
HomeScreenRepositoryImpl({required this.remoteDataSource});
  @override
  Future<MovieResponse> getAllMovies() {
    return  remoteDataSource.getAllMovies();
  }
}