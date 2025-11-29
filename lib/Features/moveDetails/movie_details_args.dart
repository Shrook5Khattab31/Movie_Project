import '../../Model/MoviesModel/Movies.dart';

class MovieDetailsArgs {
  final List<Movies> movies;
  final Movies movie;
  final String token;
  bool  fromProfile=false;
  MovieDetailsArgs(  {required this.movies,required this.movie,
    required this.token,this.fromProfile = false});
}