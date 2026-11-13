import 'package:flutter/material.dart';

import '../models/journal_model.dart';
import '../repositories/journal_repository.dart';

class JournalProvider extends ChangeNotifier {
  final JournalRepository _repository;

  List<JournalModel> _journals = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _userName = 'Made Darma Krisaryawan';
  String _userBio = 'Pecinta Seni & Budaya Pulau Dewata';
  String? _profileImagePath;

  JournalProvider({JournalRepository? repository})
    : _repository = repository ?? JournalRepository() {
    loadJournals();
  }

  List<JournalModel> get journals => _journals;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get userName => _userName;
  String get userBio => _userBio;
  String? get profileImagePath => _profileImagePath;

  void updateUserProfile(String name, String bio) {
    _userName = name;
    _userBio = bio;
    notifyListeners();
  }

  void updateProfileImage(String? path) {
    _profileImagePath = path;
    notifyListeners();
  }

  Future<void> loadJournals() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _journals = await _repository.fetchJournals();
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addJournal(JournalModel journal) async {
    await _repository.createJournal(journal);
    await loadJournals();
  }

  Future<void> updateJournal(JournalModel journal) async {
    await _repository.editJournal(journal);
    await loadJournals();
  }

  Future<void> deleteJournal(int id) async {
    await _repository.removeJournal(id);
    await loadJournals();
  }
}
