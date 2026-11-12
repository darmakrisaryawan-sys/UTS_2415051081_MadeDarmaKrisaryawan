import 'package:flutter/material.dart';
import '../widgets/culture_card.dart';
import 'culture_detail_screen.dart';

class CultureListScreen extends StatelessWidget {
  const CultureListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyCultures = [
      {
        'id': '1',
        'name': 'Tari Kecak',
        'category': 'Tari',
        'location': 'Uluwatu, Badung',
        'description': 'Pertunjukan seni tari dan drama musikal khas Bali yang dimainkan oleh puluhan penari laki-laki.',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Kecak_dance_in_Uluwatu.jpg/800px-Kecak_dance_in_Uluwatu.jpg',
      },
      {
        'id': '2',
        'name': 'Pura Besakih',
        'category': 'Pura',
        'location': 'Rendang, Karangasem',
        'description': 'Kompleks pura terbesar dan tersuci bagi umat Hindu di Bali yang terletak di lereng Gunung Agung.',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Pura_Besakih_Bali_Indonesia.jpg/800px-Pura_Besakih_Bali_Indonesia.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Budaya Bali')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 600) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                itemCount: dummyCultures.length,
                itemBuilder: (context, index) {
                  final item = dummyCultures[index];
                  return CultureCard(
                    name: item['name']!,
                    category: item['category']!,
                    location: item['location']!,
                    imageUrl: item['image']!,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CultureDetailScreen(cultureData: item),
                        ),
                      );
                    },
                  );
                },
              );
            }
            return ListView.separated(
              itemCount: dummyCultures.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = dummyCultures[index];
                return CultureCard(
                  name: item['name']!,
                  category: item['category']!,
                  location: item['location']!,
                  imageUrl: item['image']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CultureDetailScreen(cultureData: item),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}