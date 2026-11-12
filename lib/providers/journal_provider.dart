import 'package:flutter/material.dart';
import '../models/journal_model.dart';

class JournalProvider extends ChangeNotifier {
  List<JournalModel> _journals = [
    JournalModel(
      id: 1,
      cultureId: '1',
      title: 'Tari Kecak Uluwatu',
      note: 'Sangat memukau saat matahari terbenam di tebing Uluwatu!',
      rating: 5,
      createdAt: DateTime.now(),
    ),
  ];

  bool _isLoading = false;
  String? _errorMessage;
  String _userName = 'Made Darma Krisaryawan';
  String _userBio = 'Pecinta Seni & Budaya Pulau Dewata';

  List<JournalModel> get journals => _journals;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get userName => _userName;
  String get userBio => _userBio;

  void updateUserProfile(String name, String bio) {
    _userName = name;
    _userBio = bio;
    notifyListeners();
  }

  void setJournals(List<JournalModel> data) {
    _journals = data;
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

  // Simulasi CRUD lokal sementara sebelum terhubung ke Supabase di Tahap 9–12
  void addLocalJournal(JournalModel journal) {
    _journals.insert(
      0,
      JournalModel(
        id: DateTime.now().millisecondsSinceEpoch,
        cultureId: journal.cultureId,
        title: journal.title,
        note: journal.note,
        rating: journal.rating,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void updateLocalJournal(JournalModel updated) {
    final index = _journals.indexWhere((j) => j.id == updated.id);
    if (index != -1) {
      _journals[index] = updated;
      notifyListeners();
    }
  }

  void deleteLocalJournal(int id) {
    _journals.removeWhere((j) => j.id == id);
    notifyListeners();
  }
}