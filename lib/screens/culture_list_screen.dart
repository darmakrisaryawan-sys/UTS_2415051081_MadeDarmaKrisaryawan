import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/culture_provider.dart';
import '../widgets/culture_card.dart';
import '../widgets/state_feedback_widget.dart';
import 'culture_detail_screen.dart';

class CultureListScreen extends StatelessWidget {
  const CultureListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cultureProvider = context.watch<CultureProvider>();
    final cultures = cultureProvider.cultures;

    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Budaya Bali')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => cultureProvider.setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Cari nama tarian, pura, atau lokasi...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (cultureProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (cultureProvider.errorMessage != null) {
                    return StateFeedbackWidget(
                      icon: Icons.wifi_off,
                      title: 'Gagal Memuat Katalog',
                      subtitle: cultureProvider.errorMessage!,
                      actionLabel: 'Muat Ulang',
                      onAction: () => cultureProvider.loadCultures(),
                    );
                  }
                  if (cultures.isEmpty) {
                    return const StateFeedbackWidget(
                      icon: Icons.search_off,
                      title: 'Pencarian Tidak Ditemukan',
                      subtitle: 'Coba gunakan kata kunci nama budaya atau lokasi lain.',
                    );
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 600) {
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
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
                                    builder: (_) => CultureDetailScreen(culture: item),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      return ListView.separated(
                        itemCount: cultures.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
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
                                  builder: (_) => CultureDetailScreen(culture: item),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
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