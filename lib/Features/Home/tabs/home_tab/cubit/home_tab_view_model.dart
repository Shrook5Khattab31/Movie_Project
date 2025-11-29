import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/repository/Home_tab/repository/home_tab_repository.dart';
import 'home_tab_states.dart';

class HomeTabViewModel extends Cubit<HomeTabStates> {
   HomeTabRepository homeTabRepository;
  HomeTabViewModel({required this.homeTabRepository}): super(HomeTabLoadingState());

  void fetchMovies() async {
    emit(HomeTabLoadingState());
    try{
      var response =await homeTabRepository.getAllMovies();
      if(response.status=='error'){
        emit(HomeErrorState(errorMessage:response.statusMessage!));
        return;
      }
      else if(response.status=='ok'){
        emit(HomeTabSuccessState(movies:response.data?.movies??[]));
        return;
      }
    }
    catch(e){
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
