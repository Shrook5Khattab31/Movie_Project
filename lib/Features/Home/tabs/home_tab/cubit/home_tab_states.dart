import '../../../../../Model/MoviesModel/Movies.dart';

abstract class HomeTabStates {}
class HomeTabInitialState extends HomeTabStates {}
class HomeTabLoadingState extends HomeTabStates {}
class HomeTabSuccessState extends HomeTabStates {
 List<Movies> movies;
 HomeTabSuccessState({required this.movies});
}
class HomeErrorState extends HomeTabStates {
   String errorMessage;
  HomeErrorState({required this.errorMessage});
}
