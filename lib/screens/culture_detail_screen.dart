import 'package:flutter/material.dart';
import '../models/culture_model.dart';
import 'add_journal_screen.dart';

class CultureDetailScreen extends StatelessWidget {
  final CultureModel culture;

  const CultureDetailScreen({super.key, required this.culture});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(culture.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              culture.imageUrl,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 240,
                color: Colors.grey.shade300,
                child: const Center(child: Icon(Icons.temple_hindu, size: 64)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(
                      culture.category,
                      style: const TextStyle(color: Color(0xFF8B1E1E), fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: const Color(0xFF8B1E1E).withValues(alpha: 0.1),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    culture.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18, color: Color(0xFF8B1E1E)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          culture.location,
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  const Text(
                    'Deskripsi & Sejarah',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    culture.description,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddJournalScreen(
                              initialCultureId: culture.id,
                              initialTitle: culture.name,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.bookmark_add),
                      label: const Text('Simpan ke Jurnal Kunjungan'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B1E1E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}