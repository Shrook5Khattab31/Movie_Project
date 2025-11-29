import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/repository/Home_tab/repository/home_tab_repository.dart';
import '../../../data/repository/home_screen/repository/home_tab_repository.dart';
import '../tabs/home_tab/cubit/home_tab_states.dart';
import 'home_screen_states.dart';

class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenRepository homeScreenepository;
  HomeScreenViewModel({required this.homeScreenepository}): super(HomeScreenLoadingState());

  void fetchMovies() async {
    emit(HomeScreenLoadingState());
    try{
      var response =await homeScreenepository.getAllMovies();
      if(response.status=='error'){
        emit(HomeScreenErrorState(errorMessage:response.statusMessage!));
        return;
      }
      else if(response.status=='ok'){
        emit(HomeScreenSuccessState(movies:response.data?.movies??[]));
        return;
      }
    }
    catch(e){
      emit(HomeScreenErrorState(errorMessage: e.toString()));
    }
  }
}
