import 'package:flutter/material.dart';
import '../models/culture_model.dart';

class CultureProvider extends ChangeNotifier {
  List<CultureModel> _cultures = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  // Data awal sementara sebelum REST API disambungkan di Tahap 8
  CultureProvider() {
    _loadInitialDummyData();
  }

  List<CultureModel> get cultures {
    return _cultures.where((item) {
      final matchCategory = _selectedCategory == 'Semua' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();
      final matchSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.location.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

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

  void setCultures(List<CultureModel> data) {
    _cultures = data;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _loadInitialDummyData() {
    _cultures = [
      CultureModel(
        id: '1',
        name: 'Tari Kecak',
        category: 'Tari',
        location: 'Uluwatu, Kabupaten Badung',
        description: 'Pertunjukan seni tari dan drama musikal khas Bali yang dimainkan oleh puluhan penari laki-laki yang duduk melingkar dan menyerukan kata cak secara bersahutan.',
        imageUrl: 'https://jwc.gotra-resources.my.id/web-upload/1746612103-07-05-2025-sWPBRwniICoupr1FhQlE8jAxt0D74zfe.webp',
      ),
      CultureModel(
        id: '2',
        name: 'Pura Besakih',
        category: 'Pura',
        location: 'Rendang, Kabupaten Karangasem',
        description: 'Kompleks pura terbesar dan tersuci bagi umat Hindu di Bali yang terletak di lereng barat daya Gunung Agung.',
        imageUrl: 'https://www.pelago.com/img/products/ID-Indonesia/besakih-temple-tour-mother-temple-in-bali/9cd11e67-5ee4-453b-a3f9-fafcdd8e9a92_besakih-temple-tour-mother-temple-in-bali.jpg',
      ),
      CultureModel(
        id: '3',
        name: 'Upacara Ngaben',
        category: 'Upacara',
        location: 'Seluruh Bali',
        description: 'Upacara pembakaran jenazah umat Hindu di Bali sebagai proses penyucian roh (Atma) menuju alam Pitra.',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLAlfDDorqTbHXQtnSDzkdUzHVDMCykxY-auH10BhSXQ&s=10',
      ),
      CultureModel(
        id: '4',
        name: 'Gamelan Gong Kebyar',
        category: 'Musik',
        location: 'Buleleng, Bali',
        description: 'Ansambel musik tradisional Bali yang memiliki karakter permainan dinamis, cepat, dan penuh ledakan emosi musikal.',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUjSM9AWbY4_Kk42Chuw4j-PmlEeakLpo6W6HJvIF3EGnaApS426IHqvo&s=10',
      ),
    ];
  }
}