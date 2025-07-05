import 'package:flutter/material.dart';

class PropertyListPage extends StatelessWidget {
  const PropertyListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الوحدات المتاحة'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          // Filters
          Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(label: const Text('الرياض'), onSelected: (_) {}),
                  const SizedBox(width: 8),
                  FilterChip(label: const Text('مسبح'), onSelected: (_) {}),
                  const SizedBox(width: 8),
                  FilterChip(
                      label: const Text('دخول ذاتي'), onSelected: (_) {}),
                  const SizedBox(width: 8),
                  FilterChip(
                      label: const Text('أقل من 1000 ريال'),
                      onSelected: (_) {}),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Property Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return const PropertyCard();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'الحجوزات'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الحساب'),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  const PropertyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              'https://c4.wallpaperflare.com/wallpaper/804/733/150/night-lights-saudi-arabia-riyadh-hd-wallpaper-preview.jpg',
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Info
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('شاليه فاخر - الرياض',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('850 ريال / ليلة', style: TextStyle(color: Colors.teal)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    SizedBox(width: 4),
                    Text('4.6 (120 تقييم)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
