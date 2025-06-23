import 'package:flutter/material.dart';
import 'package:roomunity/widgets/ApartmentCard.dart';

/// صفحة المفضّلة التي تعرض البطاقات بنفس تصميم DepartementPage
class LovedCardPage extends StatelessWidget {
  const LovedCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesManager().favorites;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('لا توجد مفضّلة بعد'))
          : SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return ApartmentCard(images: favorites[index]);
                },
              ),
            ),
    );
  }
}
