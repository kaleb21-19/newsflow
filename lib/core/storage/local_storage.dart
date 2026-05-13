import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsflow/core/storage/hive_boxes.dart';

class LocalStorage {
  // Get already-opened boxes
  Box get _articlesBox => Hive.box(HiveBoxes.articles);
  Box get _savedArticlesBox => Hive.box(HiveBoxes.savedArticles);
  Box get _userBox => Hive.box(HiveBoxes.user);
  
   // ─── Articles ─────────────────────────────────────

Future<void> cacheArticles(List<Map<String, dynamic>> cacheArticles) async {
   
   await _articlesBox.put('cached_articles', cacheArticles);
}

/// Get cached articles
List<Map<String, dynamic>> getArticles() {
  final data = _articlesBox.get('cached_articles');
  if (data == null) return [];
  return List<Map<String, dynamic>>.from(data as List);
}

/// Clear cached articles
Future<void> clearArticles() => _articlesBox.delete('cached_articles');



  // ─── Saved Articles ───────────────────────────────
  /// Save a single article to the saved articles box
  Future<void> saveSavedArticle(String id, Map<String, dynamic> article) async {
    await _savedArticlesBox.put(id, article);
  }
  //get single article
  /// Get a single saved article by ID
  Map<String, dynamic>? getSavedArticle(String id) {
    final data = _savedArticlesBox.get(id);
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  //get all artocle

  /// Get all saved articles
  List<Map<String, dynamic>> getAllSavedArticles() {
    final data = _savedArticlesBox.values.toList();
    return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }
  
  /// Delete a saved article by ID
  Future<void> deleteSavedArticle(String id) =>
      _savedArticlesBox.delete(id);


  bool isArticleSaved(String id) => _savedArticlesBox.containsKey(id);
  
    // ─── User ─────────────────────────────────────────

  Future<void> saveUser(Map<String, dynamic> user) =>
      _userBox.put('current_user', user);

  Map<String, dynamic>? getUser() {
    final data = _userBox.get('current_user');
    if (data == null) return null;
    return Map<String, dynamic>.from(data as Map);
  }

  Future<void> clearUser() => _userBox.delete('current_user');

  // ─── Clear All ────────────────────────────────────

  Future<void> clearAll() async {
    await _articlesBox.clear();
    await _savedArticlesBox.clear();
    await _userBox.clear();
  }
}
