import 'package:flutter/material.dart';
import '../widgets/category_chip.dart';
import '../widgets/culture_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Semua';
  final List<String> _categories = ['Semua', 'Tari', 'Pura', 'Upacara', 'Musik'];

  final _dummyCultures = [
    {
      'name': 'Tari Kecak',
      'category': 'Tari',
      'location': 'Uluwatu, Badung',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Kecak_dance_in_Uluwatu.jpg/800px-Kecak_dance_in_Uluwatu.jpg',
    },
    {
      'name': 'Pura Besakih',
      'category': 'Pura',
      'location': 'Rendang, Karangasem',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Pura_Besakih_Bali_Indonesia.jpg/800px-Pura_Besakih_Bali_Indonesia.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BaliCulture'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B1E1E), Color(0xFFB73E3E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jelajahi Warisan Budaya Bali',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Temukan seni tari, pura bersejarah, dan tradisi sakral Pulau Dewata.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Filter Kategori Horizontal
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return CategoryChip(
                    label: cat,
                    isSelected: _selectedCategory == cat,
                    onSelected: () {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Katalog Budaya',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Daftar Katalog Awal
            Expanded(
              child: ListView.separated(
                itemCount: _dummyCultures.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _dummyCultures[index];
                  return CultureCard(
                    name: item['name']!,
                    category: item['category']!,
                    location: item['location']!,
                    imageUrl: item['image']!,
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}