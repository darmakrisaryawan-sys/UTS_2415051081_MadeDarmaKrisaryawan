import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/journal_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;
  static const String _tableName = 'culture_journals';

  Future<List<JournalModel>> getJournals() async {
    try {
      final response = await _client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      return (response as List<dynamic>)
          .map((item) => JournalModel.fromJson(item))
          .toList();
    } on SocketException {
      throw Exception('Tidak ada koneksi internet untuk memuat jurnal.');
    } on PostgrestException catch (e) {
      throw Exception('Kesalahan database: ${e.message}');
    } catch (e) {
      throw Exception('Gagal memuat data jurnal: $e');
    }
  }

  Future<void> insertJournal(JournalModel journal) async {
    try {
      await _client.from(_tableName).insert(journal.toJson());
    } on SocketException {
      throw Exception('Gagal menyimpan: Periksa koneksi internet Anda.');
    } on PostgrestException catch (e) {
      throw Exception('Gagal menyimpan ke database: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan saat menyimpan: $e');
    }
  }

  Future<void> updateJournal(JournalModel journal) async {
    if (journal.id == null) throw Exception('ID jurnal tidak valid');
    try {
      await _client
          .from(_tableName)
          .update(journal.toJson())
          .eq('id', journal.id!);
    } on SocketException {
      throw Exception('Gagal memperbarui: Periksa koneksi internet Anda.');
    } on PostgrestException catch (e) {
      throw Exception('Gagal memperbarui database: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan saat memperbarui: $e');
    }
  }

  Future<void> deleteJournal(int id) async {
    try {
      await _client.from(_tableName).delete().eq('id', id);
    } on SocketException {
      throw Exception('Gagal menghapus: Periksa koneksi internet Anda.');
    } on PostgrestException catch (e) {
      throw Exception('Gagal menghapus dari database: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan saat menghapus: $e');
    }
  }
}
