import 'package:flutter/material.dart';
import 'package:roomunity/pages/lovedpage.dart';

// Core favorites manager accessible from any page
class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<List<String>> _favorites = [];

  List<List<String>> get favorites => List.unmodifiable(_favorites);

  bool isFavorite(List<String> item) {
    return _favorites.any((f) => _listEquals(f, item));
  }

  void toggleFavorite(List<String> item) {
    if (isFavorite(item)) {
      _favorites.removeWhere((f) => _listEquals(f, item));
    } else {
      _favorites.add(item);
    }
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apartments',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const DepartementPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DepartementPage extends StatelessWidget {
  const DepartementPage({super.key});

  final List<List<String>> imageGroups = const [
    [
      'https://picsum.photos/id/101/200/200',
      'https://picsum.photos/id/102/200/200',
      'https://picsum.photos/id/103/200/200'
    ],
    [
      'https://picsum.photos/id/104/200/200',
      'https://picsum.photos/id/105/200/200',
      'https://picsum.photos/id/106/200/200'
    ],
    [
      'https://picsum.photos/id/107/200/200',
      'https://picsum.photos/id/108/200/200',
      'https://picsum.photos/id/109/200/200'
    ],
    [
      'https://picsum.photos/id/110/200/200',
      'https://picsum.photos/id/111/200/200',
      'https://picsum.photos/id/112/200/200'
    ],
    [
      'https://picsum.photos/id/113/200/200',
      'https://picsum.photos/id/114/200/200',
      'https://picsum.photos/id/115/200/200'
    ],
    [
      'https://picsum.photos/id/116/200/200',
      'https://picsum.photos/id/117/200/200',
      'https://picsum.photos/id/118/200/200'
    ],
    [
      'https://picsum.photos/id/119/200/200',
      'https://picsum.photos/id/120/200/200',
      'https://picsum.photos/id/121/200/200'
    ],
    [
      'https://picsum.photos/id/122/200/200',
      'https://picsum.photos/id/123/200/200',
      'https://picsum.photos/id/124/200/200'
    ],
    [
      'https://picsum.photos/id/125/200/200',
      'https://picsum.photos/id/126/200/200',
      'https://picsum.photos/id/127/200/200'
    ],
    [
      'https://picsum.photos/id/128/200/200',
      'https://picsum.photos/id/129/200/200',
      'https://picsum.photos/id/130/200/200'
    ],
    [
      'https://picsum.photos/id/131/200/200',
      'https://picsum.photos/id/132/200/200',
      'https://picsum.photos/id/133/200/200'
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apartments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LovedCardPage()),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: imageGroups.length,
          itemBuilder: (context, index) {
            return ApartmentCard(images: imageGroups[index]);
          },
        ),
      ),
    );
  }
}

/// بطاقة الشقة مع Carousel ونقاط ديناميكية وأيقونة قلب تفاعلية
class ApartmentCard extends StatefulWidget {
  final List<String> images;

  const ApartmentCard({super.key, required this.images});

  @override
  State<ApartmentCard> createState() => _ApartmentCardState();
}

class _ApartmentCardState extends State<ApartmentCard> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    final favManager = FavoritesManager();
    bool isFav = favManager.isFavorite(images);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel الصور
              SizedBox(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, pageIndex) {
                    return ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.network(
                        images[pageIndex],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  },
                ),
              ),

              // نقاط المؤشر
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (i) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == i ? 12 : 8,
                      height: _currentPage == i ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == i
                            ? Colors.purple
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),
              ),

              // بيانات الشقة
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text("9.8 (127 Reviews)",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Spacer(),
                        Text("OFF 29%",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text("Apartment with Living room",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    SizedBox(height: 4),
                    Text("Riyadh - Al Taawun Dist."),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.bed, size: 20),
                        SizedBox(width: 4),
                        Text("1"),
                        SizedBox(width: 16),
                        Icon(Icons.bathtub, size: 20),
                        SizedBox(width: 4),
                        Text("1"),
                        SizedBox(width: 16),
                        Icon(Icons.person, size: 20),
                        SizedBox(width: 4),
                        Text("1"),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text("16,211 SAR",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough)),
                        SizedBox(width: 8),
                        Text("11,509.81 /Month",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("Total (29 Nights) 12,775.88 SAR"),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),

        // أيقونة القلب التفاعلية
        Positioned(
          top: 24,
          right: 16,
          child: GestureDetector(
            onTap: () {
              setState(() {
                favManager.toggleFavorite(widget.images);
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                favManager.isFavorite(widget.images)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favManager.isFavorite(widget.images)
                    ? Colors.red
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// صفحة المفضّلة بدون تمرير البيانات، تقرأ من FavoritesManager مباشرة
