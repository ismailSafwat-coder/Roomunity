import 'package:flutter/material.dart';
import 'package:roomunity/main.dart';
import 'package:roomunity/widgets/pymentmethoud.dart';

class RoomDetailsPage extends StatefulWidget {
  const RoomDetailsPage({super.key});

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1505691938895-1758d7feb511',
    'https://images.unsplash.com/photo-1513694203232-719a280e022f',
    'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e',
  ];
  int _currentIndex = 0;
  bool _isLiked = false;
  final PageController _pageController = PageController();

  // Info icon widget for details row
  Widget _infoIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6C4AB6), size: 22),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Info icon widget for details row
  Widget infoIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF6C4AB6), size: 22),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Payment methods
  final List<Map<String, dynamic>> paymentMethods = [
    {'name': 'تمارا', 'icon': Icons.account_balance_wallet},
    {'name': 'STC Pay', 'icon': Icons.phone_android},
    {'name': 'اليوم', 'icon': Icons.payment},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: deviceheight * 0.48,
              child: Stack(
                children: [
                  // Image Gallery with Swipe
                  _buildImageGallery(),
                  // Top Navigation Bar
                  _buildTopBar(),
                  // Image Indicators
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 60,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (index) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                  // Bottom Action Bar
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _buildBottomBar(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Discount badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.15),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_offer,
                              color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'خصم 20%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'جديد ',
                        style: midTextStyle,
                      ),
                      Icon(Icons.star, color: Colors.black, size: 30),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),
            // Main details card
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'شقة بغرفة نوم وصالة',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'الباحة - حي الصفا',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            const PaymentMethodsCard(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardroomdetails2(Icons.bed, '4'),
                cardroomdetails2(Icons.square_foot, '100 m²'),
                cardroomdetails2(Icons.verified_user, '100 \$'),
              ],
            ),
            //space form bottom
            SizedBox(
              height: deviceheight * 0.05,
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: deviceheight * 0.13,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ليلة/ 399.20 ر.س',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C4AB6),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'إجمالي (ليلة واحدة) 443.11 ر.س',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF888888),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C4AB6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 36, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'اختر',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container cardroomdetails2(IconData? icon, String text) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[100],
        border:
            Border.all(width: 2, color: const Color.fromRGBO(200, 200, 200, 1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget _buildImageGallery() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: images.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          return Image.network(
            images[index],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  // Share functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Room shared!')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Modern Luxury Room',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isLiked ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked ? Colors.red : Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  setState(() => _isLiked = !_isLiked);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Video Button
              ElevatedButton.icon(
                icon: const Icon(Icons.videocam, color: Colors.white),
                label: const Text('View Video',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Video functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening room video...')),
                  );
                },
              ),

              // Navigation Arrows
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        if (_currentIndex > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_forward, color: Colors.white),
                      onPressed: () {
                        if (_currentIndex < images.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
