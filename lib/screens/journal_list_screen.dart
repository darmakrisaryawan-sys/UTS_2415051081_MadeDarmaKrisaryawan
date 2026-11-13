import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/journal_model.dart';
import '../providers/journal_provider.dart';
import '../widgets/state_feedback_widget.dart';
import 'add_journal_screen.dart';
import 'edit_journal_screen.dart';

class JournalListScreen extends StatelessWidget {
  const JournalListScreen({super.key});

  Future<void> _confirmDelete(BuildContext context, JournalModel item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Jurnal?'),
        content: Text(
          'Apakah Anda yakin ingin menghapus catatan "${item.title}" secara permanen?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true && item.id != null && context.mounted) {
      try {
        await context.read<JournalProvider>().deleteJournal(item.id!);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Jurnal berhasil dihapus dari database!'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = context.watch<JournalProvider>();
    final journals = journalProvider.journals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jurnal & Favorit Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang jurnal',
            onPressed: () => journalProvider.loadJournals(),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (journalProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (journalProvider.errorMessage != null) {
            return StateFeedbackWidget(
              icon: Icons.cloud_off,
              title: 'Gagal Memuat Jurnal',
              subtitle: journalProvider.errorMessage!,
              actionLabel: 'Coba Lagi',
              onAction: () => journalProvider.loadJournals(),
            );
          }
          if (journals.isEmpty) {
            return const StateFeedbackWidget(
              icon: Icons.bookmark_border,
              title: 'Belum Ada Jurnal',
              subtitle: 'Tekan tombol + Tambah Jurnal untuk menyimpan pengalaman budaya Bali Anda.',
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: journals.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = journals[index];
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF8B1E1E),
                    child: Icon(Icons.book, color: Colors.white),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Rating: ${item.rating}/5 •${item.note}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blueGrey),
                        tooltip: 'Edit Jurnal',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditJournalScreen(
                                journalId: item.id ?? 0,
                                cultureId: item.cultureId,
                                initialTitle: item.title,
                                initialNote: item.note,
                                initialRating: item.rating,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        tooltip: 'Hapus Jurnal',
                        onPressed: () => _confirmDelete(context, item),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddJournalScreen()),
          );
        },
        backgroundColor: const Color(0xFF8B1E1E),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Jurnal'),
      ),
    );
  }
}
