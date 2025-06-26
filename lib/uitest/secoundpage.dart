import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ApartmentListingScreen extends StatefulWidget {
  const ApartmentListingScreen({super.key});

  @override
  _ApartmentListingScreenState createState() => _ApartmentListingScreenState();
}

class _ApartmentListingScreenState extends State<ApartmentListingScreen> {
  final PageController _controller = PageController();
  final List<String> imageList = [
    'https://www.portugal.com/wp-content/uploads/2025/02/Ronaldo_in_2018-696x825.jpg',
    'https://www.portugal.com/wp-content/uploads/2025/02/Ronaldo_in_2018-696x825.jpg',
    'https://www.portugal.com/wp-content/uploads/2025/02/Ronaldo_in_2018-696x825.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Image.network(
                            imageList[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const Positioned(
                            top: 16,
                            left: 16,
                            child: Row(
                              children: [
                                Icon(Icons.share, color: Colors.white),
                                SizedBox(width: 10),
                                Icon(Icons.favorite_border,
                                    color: Colors.white),
                              ],
                            ),
                          ),
                          if (index == 0)
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                color: Colors.red,
                                child: const Text(
                                  'خصم %20',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          const Positioned(
                            bottom: 16,
                            right: 16,
                            child: Icon(Icons.play_circle_fill,
                                color: Colors.white, size: 40),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: imageList.length,
                      effect: const WormEffect(
                        dotColor: Colors.white54,
                        activeDotColor: Colors.white,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const Text('شقة جديدة - غرفة وصالة',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('الباحة - حي الصفا',
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(height: 4),
                    Text('(756359)', style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 16),
                    const Row(
                      children: [
                        Text('499 ر.س',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey)),
                        SizedBox(width: 8),
                        Text('399.20 ر.س',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('السعر مع الضريبة: 443.11 ر.س',
                        style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ادفع على 4 دفعات بدون فوائد عبر:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Image.network(
                                  'https://www.portugal.com/wp-content/uploads/2025/02/Ronaldo_in_2018-696x825.jpg',
                                  height: 30),
                              const SizedBox(width: 16),
                              Image.network(
                                  'https://www.portugal.com/wp-content/uploads/2025/02/Ronaldo_in_2018-696x825.jpg',
                                  height: 30),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('اكسب 44 نقطة stc pay مع هذا الحجز.',
                        style: TextStyle(color: Colors.deepPurple)),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('اختر', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
