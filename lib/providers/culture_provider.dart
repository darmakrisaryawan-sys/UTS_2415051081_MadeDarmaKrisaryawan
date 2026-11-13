import 'package:flutter/material.dart';

import '../models/culture_model.dart';
import '../repositories/culture_repository.dart';

class CultureProvider extends ChangeNotifier {
  final CultureRepository _repository;

  List<CultureModel> _cultures = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  CultureProvider({CultureRepository? repository})
    : _repository = repository ?? CultureRepository() {
    loadCultures();
  }

  List<CultureModel> get cultures {
    return _cultures.where((item) {
      final matchCategory =
          _selectedCategory == 'Semua' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchSearch =
          item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.location.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

  int get totalCulturesCount => _cultures.length;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> loadCultures() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _cultures = await _repository.getCultures();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
