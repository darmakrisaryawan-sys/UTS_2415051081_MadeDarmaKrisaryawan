import 'package:flutter/material.dart';
import 'add_journal_screen.dart';
import 'edit_journal_screen.dart';

class JournalListScreen extends StatelessWidget {
  const JournalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jurnal & Favorit Saya')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF8B1E1E),
                child: Icon(Icons.book, color: Colors.white),
              ),
              title: const Text('Tari Kecak Uluwatu'),
              subtitle: const Text('Rating: 5/5 • Sangat memukau saat sunset!'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EditJournalScreen(
                        journalId: 1,
                        initialTitle: 'Tari Kecak Uluwatu',
                        initialNote: 'Sangat memukau saat sunset!',
                        initialRating: 5,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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