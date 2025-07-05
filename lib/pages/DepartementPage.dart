import 'package:flutter/material.dart';
import 'package:roomunity/pyment/payment_page.dart';
import 'package:roomunity/widgets/ApartmentCard.dart';

class DepartementPage extends StatefulWidget {
  const DepartementPage({super.key});

  @override
  State<DepartementPage> createState() => _DepartementPageState();
}

class _DepartementPageState extends State<DepartementPage> {
  // للـ PageView داخل كل بطاقة
  final List<String> sampleImages = [
    'https://c1.wallpaperflare.com/preview/617/83/702/real-estate-sample-room-hainan.jpg',
    'https://c0.wallpaperflare.com/preview/792/23/682/screen-computer-desktop-monitor.jpg',
    'https://c1.wallpaperflare.com/preview/578/107/648/minimal-room-coffee-table-white.jpg',
  ];

  final List<List<String>> imageGroups = const [
    [
      'https://picsum.photos/id/101/200/200',
      'https://picsum.photos/id/102/200/200',
      'https://picsum.photos/id/103/200/200',
    ],
    [
      'https://picsum.photos/id/104/200/200',
      'https://picsum.photos/id/105/200/200',
      'https://picsum.photos/id/106/200/200',
    ],
    [
      'https://picsum.photos/id/107/200/200',
      'https://picsum.photos/id/108/200/200',
      'https://picsum.photos/id/109/200/200',
    ],
    [
      'https://picsum.photos/id/110/200/200',
      'https://picsum.photos/id/111/200/200',
      'https://picsum.photos/id/112/200/200',
    ],
    [
      'https://picsum.photos/id/113/200/200',
      'https://picsum.photos/id/114/200/200',
      'https://picsum.photos/id/115/200/200',
    ],
    [
      'https://picsum.photos/id/116/200/200',
      'https://picsum.photos/id/117/200/200',
      'https://picsum.photos/id/118/200/200',
    ],
    [
      'https://picsum.photos/id/119/200/200',
      'https://picsum.photos/id/120/200/200',
      'https://picsum.photos/id/121/200/200',
    ],
    [
      'https://picsum.photos/id/122/200/200',
      'https://picsum.photos/id/123/200/200',
      'https://picsum.photos/id/124/200/200',
    ],
    [
      'https://picsum.photos/id/125/200/200',
      'https://picsum.photos/id/126/200/200',
      'https://picsum.photos/id/127/200/200',
    ],
    [
      'https://picsum.photos/id/128/200/200',
      'https://picsum.photos/id/129/200/200',
      'https://picsum.photos/id/130/200/200',
    ],
    [
      'https://picsum.photos/id/131/200/200',
      'https://picsum.photos/id/132/200/200',
      'https://picsum.photos/id/133/200/200',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // شريط البحث مع زر الرجوع
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.arrow_back, size: 28),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Riyadh',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black87),
                            ),
                          ),
                          Icon(Icons.location_on, color: Colors.purple),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // شريط الفلاتر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip('Farm +4', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('District', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Price', false),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // قائمة الشقق
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: imageGroups.length,
                itemBuilder: (context, index) {
                  final image = imageGroups[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ApartmentCard(images: image),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? Colors.purple : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildApartmentCard(BuildContext contex, List<String> image) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Carousel الصور
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: image.length,
                  itemBuilder: (context, pageIndex) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const PaymentPage())));
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.network(
                          image[pageIndex],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // مؤشرات Carousel
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    sampleImages.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == 0 ? Colors.purple : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),

              // بيانات الشقة
              const Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // التقييم والخصم
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

                    // العنوان
                    Text(
                      "Apartment with Living room",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text("Riyadh - Al Taawun Dist."),
                    SizedBox(height: 12),

                    // الأيقونات (سرير، حمام، أشخاص)
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

                    // الأسعار
                    Row(
                      children: [
                        Text(
                          "16,211 SAR",
                          style:
                              TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "11,509.81 /Month",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("Total (29 Nights) 12,775.88 SAR"),
                  ],
                ),
              ),
            ],
          ),
        ),

        // أيقونة القلب
        const Positioned(
          top: 12,
          right: 12,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite_border, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
