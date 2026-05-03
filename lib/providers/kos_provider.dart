import 'package:flutter/foundation.dart';
import '../models/kos.dart';

class KosProvider with ChangeNotifier {
  List<String> _favoriteKosIds = [];

  // Filter state (used by home_screen & filter_bottom_sheet)
  String _selectedLocation = '';
  String _selectedType = '';
  List<String> _selectedPriceRanges = [];
  String _searchQuery = '';

  // Getters
  List<String> get favoriteKosIds => _favoriteKosIds;
  String get selectedLocation => _selectedLocation;
  String get selectedType => _selectedType;
  List<String> get selectedPriceRanges => List.unmodifiable(_selectedPriceRanges);

  void toggleFavorite(String id) {
    if (_favoriteKosIds.contains(id)) {
      _favoriteKosIds.remove(id);
    } else {
      _favoriteKosIds.add(id);
    }
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoriteKosIds.contains(id);
  }

  List<Kos> get filteredKosList {
    return [];
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void applyFilters({
    required String location,
    required String type,
    required List<String> priceRanges,
  }) {
    _selectedLocation = location;
    _selectedType = type;
    _selectedPriceRanges = List.from(priceRanges);
    notifyListeners();
  }

  void clearFilters() {
    _selectedLocation = '';
    _selectedType = '';
    _selectedPriceRanges = [];
    _searchQuery = '';
    notifyListeners();
  }
}
