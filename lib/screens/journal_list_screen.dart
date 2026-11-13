import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/journal_provider.dart';
import '../widgets/state_feedback_widget.dart';
import 'add_journal_screen.dart';
import 'edit_journal_screen.dart';

class JournalListScreen extends StatelessWidget {
  const JournalListScreen({super.key});

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
                  subtitle: Text('Rating: ${item.rating}/5 • ${item.note}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditJournalScreen(
                            journalId: item.id ?? 0,
                            initialTitle: item.title,
                            initialNote: item.note,
                            initialRating: item.rating,
                          ),
                        ),
                      );
                    },
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
