import '../models/journal_model.dart';
import '../services/supabase_service.dart';

class JournalRepository {
  final SupabaseService _supabaseService;

  JournalRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService();

  Future<List<JournalModel>> fetchJournals() => _supabaseService.getJournals();
  Future<void> createJournal(JournalModel journal) => _supabaseService.insertJournal(journal);
  Future<void> editJournal(JournalModel journal) => _supabaseService.updateJournal(journal);
  Future<void> removeJournal(int id) => _supabaseService.deleteJournal(id);
}