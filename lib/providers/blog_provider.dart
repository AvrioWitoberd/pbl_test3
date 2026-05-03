import 'package:flutter/foundation.dart';
import '../models/blog.dart';

class BlogProvider with ChangeNotifier {
  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  void updateCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<Blog> get filteredBlogs {
    return [];
  }

  void updateSearchQuery(String query) {
    // empty function
  }
}
