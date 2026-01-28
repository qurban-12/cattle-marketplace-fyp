import 'package:flutter/foundation.dart';

class FavoritesManager extends ChangeNotifier {
  // Singleton pattern
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final Set<String> _favoriteIds = {}; // Store unique IDs
  final List<Map<String, dynamic>> _favoritedCattle = [];

  List<Map<String, dynamic>> get favoritedCattle => _favoritedCattle;
  int get count => _favoritedCattle.length;

  bool isFavorite(String id) {
    return _favoriteIds.contains(id);
  }

  void addFavorite(Map<String, dynamic> cattle) {
    final id = cattle['name'] + cattle['location']; // Simple ID
    if (!_favoriteIds.contains(id)) {
      _favoriteIds.add(id);
      _favoritedCattle.add({...cattle, 'id': id});
      notifyListeners();
    }
  }

  void removeFavorite(String id) {
    _favoriteIds.remove(id);
    _favoritedCattle.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }

  void toggleFavorite(Map<String, dynamic> cattle) {
    final id = cattle['name'] + cattle['location'];
    if (isFavorite(id)) {
      removeFavorite(id);
    } else {
      addFavorite(cattle);
    }
  }
}
