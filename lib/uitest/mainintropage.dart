import 'package:flutter/material.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/ui/introscreens/intropage1.dart';
import 'package:roomunity/ui/introscreens/intropage2.dart';
import 'package:roomunity/ui/introscreens/intropage3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MainintropageTest extends StatefulWidget {
  const MainintropageTest({super.key});

  @override
  State<MainintropageTest> createState() => _MainintropageTestState();
}

class _MainintropageTestState extends State<MainintropageTest> {
  final PageController controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4A00E0),
                  Color(0xFF8E2DE2),
                ],
              ),
            ),
          ),

          // Intro PageView
          PageView(
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == 2;
              });
            },
            controller: controller,
            children: const [
              Intropage1(),
              Intropage2(),
              Intropage3(),
            ],
          ),

          // Controls at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white30,
                      expansionFactor: 4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Skip / Next / Get Started Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => controller.jumpToPage(2),
                        child: const Text('Skip'),
                      ),
                      if (!isLastPage)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () => controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          ),
                          child: const Text('Next'),
                        )
                      else
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: const Color(0xFF4A00E0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Mainpage(),
                              ),
                            );
                          },
                          child: const Text('Get Started'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
