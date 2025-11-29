import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Model/MoviesModel/Movies.dart';

class HistoryService {

  static String _keyForUser(String userId) => "movie_history_$userId";

  static final StreamController<List<Movies>> _historyController =
  StreamController.broadcast();

  static Stream<List<Movies>> get historyStream => _historyController.stream;

  static Future<void> addMovieToHistory(Movies movie, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForUser(userId);

    List<String> history = prefs.getStringList(key) ?? [];
    history.removeWhere((item) =>
    Movies
        .fromJson(jsonDecode(item))
        .id == movie.id);
    history.insert(0, jsonEncode(movie.toJson()));

    if (history.length > 30) {
      history = history.sublist(0, 30);
    }

    await prefs.setStringList(key, history);
    _historyController.add(
        history.map((item) => Movies.fromJson(jsonDecode(item))).toList()
    );
  }

  static Future<List<Movies>> getHistory(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _keyForUser(userId);
    List<String> history = prefs.getStringList(key) ?? [];
    return history.map((item) => Movies.fromJson(jsonDecode(item))).toList();
  }


  static void dispose() {
    _historyController.close();
  }
}
