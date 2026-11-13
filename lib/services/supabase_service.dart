import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/journal_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;
  static const String _tableName = 'culture_journals';

  // READ: Ambil seluruh jurnal dari database
  Future<List<JournalModel>> getJournals() async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((item) => JournalModel.fromJson(item))
          .toList();
    } catch (e) {
      throw Exception('Gagal memuat data database: $e');
    }
  }

  // CREATE: Tambah jurnal baru
  Future<void> insertJournal(JournalModel journal) async {
    try {
      await _client.from(_tableName).insert(journal.toJson());
    } catch (e) {
      throw Exception('Gagal menyimpan ke database: $e');
    }
  }

  // UPDATE: Perbarui jurnal berdasarkan ID
  Future<void> updateJournal(JournalModel journal) async {
    if (journal.id == null) throw Exception('ID jurnal tidak valid');
    try {
      await _client
          .from(_tableName)
          .update(journal.toJson())
          .eq('id', journal.id!);
    } catch (e) {
      throw Exception('Gagal memperbarui data: $e');
    }
  }

  // DELETE: Hapus jurnal berdasarkan ID
  Future<void> deleteJournal(int id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Gagal menghapus data: $e');
    }
  }
}