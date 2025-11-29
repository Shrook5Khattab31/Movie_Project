
import 'package:movie_project/api/api_service.dart';
import '../data/repository/Home_tab/data_source/remote/home_remote_data_source.dart';
import '../data/repository/Home_tab/repository/home_tab_repository.dart';
import '../data/repository/Home_tab/repository/impl/home_remote_data_source_impl.dart';
import '../data/repository/Home_tab/repository/impl/home_tab_repository_impl.dart';
import '../data/repository/home_screen/datasource/remote/home_screen_remote_data_source.dart';
import '../data/repository/home_screen/repository/home_tab_repository.dart';
import '../data/repository/home_screen/repository/impl/home_screen_remote_data_source_impl.dart';
import '../data/repository/home_screen/repository/impl/home_screen_repository_impl.dart';

HomeTabRepository injectHomeTabRepository (){
  return HomeTabRepositoryImpl(remoteDataSource: injectHomeRemoteDataSource());
}
HomeRemoteDataSource injectHomeRemoteDataSource(){
  return HomeRemoteDataSourceImpl(apiService:injectApiService());
}
ApiService injectApiService(){
  return ApiService();
}
HomeScreenRepository injectHomeScreenRepository (){
  return HomeScreenRepositoryImpl(remoteDataSource: injectHomeScreenRemoteDataSource());
}
HomeScreenRemoteDataSource injectHomeScreenRemoteDataSource(){
  return HomeScreenRemoteDataSourceImpl(apiService:injectApiService());
}

