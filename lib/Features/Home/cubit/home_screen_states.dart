import '../../../../../Model/MoviesModel/Movies.dart';

abstract class HomeScreenStates {}
class HomeScreenInitialState extends HomeScreenStates {}
class HomeScreenLoadingState extends HomeScreenStates {}
class HomeScreenSuccessState extends HomeScreenStates {
 List<Movies> movies;
 HomeScreenSuccessState ({required this.movies});
}
class HomeScreenErrorState extends HomeScreenStates {
   String errorMessage;
   HomeScreenErrorState({required this.errorMessage});
}
