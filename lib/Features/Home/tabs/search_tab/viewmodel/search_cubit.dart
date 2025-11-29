import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../Model/MoviesModel/Movies.dart';
import '../../../../../api/api_service.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  TextEditingController searchController = TextEditingController();
  List<String> recentSearches = [];
  bool isTextFieldFocused = false;

  void setFocus(bool focus) {
    isTextFieldFocused = focus;
    if (focus && searchController.text.isEmpty && recentSearches.isNotEmpty) {
      emit(SearchFocus());
    } else {
      emit(SearchInitial());
    }
  }

  void addRecent(String text) {
    if (!recentSearches.contains(text)) {
      //todo already found movie --> change place
      recentSearches.insert(0, text);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
    }
    emit(SearchInitial());
  }

  Future<void> getMovieBySearch(String text) async {
    if (text.isEmpty) {
      setFocus(true);
      return;
    }
    addRecent(text);
    emit(SearchLoading());

    try {
      final result = await ApiService.searchMovies(text);
      if (result.isEmpty) {
        emit(SearchEmpty());
        return;
      }

      emit(SearchSuccess(movieList: result));
    } catch (e) {
      emit(SearchError(errorMessage: e.toString()));
    }
  }

  void clearSearch() {
    searchController.clear();
    emit(SearchInitial());
  }
}
