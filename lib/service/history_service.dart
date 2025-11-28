import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/MoviesModel/Movies.dart';

class HistoryService {
  static const String key = "movie_history";

  static final StreamController<List<Map<String, dynamic>>> _historyController =
  StreamController.broadcast();

  static Stream<List<Map<String, dynamic>>> get historyStream => _historyController.stream;
  static Future<void> addMovieToHistory(Movies movie) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(key) ?? [];
    history.removeWhere((item) => jsonDecode(item)["id"] == movie.id);
    history.insert(0, jsonEncode(movie.toJson()));

    if (history.length > 30) {
      history = history.sublist(0, 30);
    }

    await prefs.setStringList(key, history);
    _historyController.add(history.map((item) => Map<String, dynamic>.from(jsonDecode(item))).toList());
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(key) ?? [];
    return history.map((item) => Map<String, dynamic>.from(jsonDecode(item))).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _historyController.add([]);
  }

  static void dispose() {
    _historyController.close();
  }
}