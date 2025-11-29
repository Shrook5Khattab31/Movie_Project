
import 'package:movie_project/api/api_service.dart';
import 'package:movie_project/data/repository/Home_tab/data_source/remote/home_remote_data_source.dart';
import 'package:movie_project/data/repository/Home_tab/repository/impl/home_remote_data_source_impl.dart';
import 'package:movie_project/data/repository/Home_tab/repository/impl/home_tab_repository_impl.dart';
import 'package:movie_project/data/repository/home_screen/repository/home_tab_repository.dart';
import 'package:movie_project/data/repository/home_screen/repository/impl/home_screen_repository_impl.dart';
import '../data/repository/Home_tab/repository/home_tab_repository.dart';
import '../data/repository/home_screen/repository/impl/home_screen_remote_data_source_impl.dart';

ApiService injectApiService() {
  return ApiService();
 }
HomeTabRepository  injectHomeTabRepository() {
  return HomeTabRepositoryImpl(remoteDataSource: injectHomeTabRemoteDataSource());
}

HomeRemoteDataSource  injectHomeTabRemoteDataSource() {
  return HomeRemoteDataSourceImpl(apiService: injectApiService());
}
HomeScreenRemoteDataSourceImpl injectHomeScreenRemoteDataSource() {
  return HomeScreenRemoteDataSourceImpl(apiService: injectApiService());
}
HomeScreenRepository injectHomeScreenRepository() {
  return HomeScreenRepositoryImpl(remoteDataSource: injectHomeScreenRemoteDataSource());
}


