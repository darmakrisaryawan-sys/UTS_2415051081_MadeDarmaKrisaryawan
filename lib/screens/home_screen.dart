import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/culture_provider.dart';
import '../widgets/category_chip.dart';
import '../widgets/culture_card.dart';
import '../widgets/state_feedback_widget.dart';
import 'culture_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cultureProvider = context.watch<CultureProvider>();
    final categories = ['Semua', 'Tari', 'Pura', 'Upacara', 'Musik', 'Tradisi'];
    final cultures = cultureProvider.cultures;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BaliCulture'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang API',
            onPressed: () => cultureProvider.loadCultures(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    'Temukan seni tari, pura bersejarah, upacara, musik, dan tradisi sakral Pulau Dewata.',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Filter Kategori Horizontal (Termasuk Tradisi)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return CategoryChip(
                    label: cat,
                    isSelected: cultureProvider.selectedCategory == cat,
                    onSelected: () => cultureProvider.setCategory(cat),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Katalog ${cultureProvider.selectedCategory}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${cultures.length} Item',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (cultureProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (cultureProvider.errorMessage != null) {
                    return StateFeedbackWidget(
                      icon: Icons.wifi_off,
                      title: 'Gagal Memuat Data',
                      subtitle: cultureProvider.errorMessage!,
                      actionLabel: 'Coba Lagi',
                      onAction: () => cultureProvider.loadCultures(),
                    );
                  }
                  if (cultures.isEmpty) {
                    return const StateFeedbackWidget(
                      icon: Icons.search_off,
                      title: 'Tidak Ada Data',
                      subtitle: 'Budaya pada kategori ini belum tersedia.',
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => cultureProvider.loadCultures(),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth >= 600) {
                          final crossAxisCount = constraints.maxWidth >= 900
                              ? 3
                              : 2;
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 1.05,
                                ),
                            itemCount: cultures.length,
                            itemBuilder: (context, index) {
                              final item = cultures[index];
                              return CultureCard(
                                name: item.name,
                                category: item.category,
                                location: item.location,
                                imageUrl: item.imageUrl,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CultureDetailScreen(culture: item),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                        return ListView.separated(
                          itemCount: cultures.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = cultures[index];
                            return CultureCard(
                              name: item.name,
                              category: item.category,
                              location: item.location,
                              imageUrl: item.imageUrl,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        CultureDetailScreen(culture: item),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
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
