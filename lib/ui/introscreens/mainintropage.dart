import 'package:flutter/material.dart';
import 'package:roomunity/pages/homepage.dart';
import 'package:roomunity/ui/introscreens/intropage1.dart';
import 'package:roomunity/ui/introscreens/intropage2.dart';
import 'package:roomunity/ui/introscreens/intropage3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Mainintropage extends StatefulWidget {
  const Mainintropage({super.key});

  @override
  State<Mainintropage> createState() => _MainintropageState();
}

class _MainintropageState extends State<Mainintropage> {
  final PageController controller = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2); // Check if the last page is reached
              });
            },
            controller: controller,
            children: const [
              Intropage1(),
              Intropage2(),
              Intropage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    controller.jumpToPage(2); // Skip to the last page
                  },
                ),
                SmoothPageIndicator(controller: controller, count: 3),
                isLastPage
                    ? // Show 'Get Started' button only on the last page
                    TextButton(
                        child: const Text('Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Homepage(), // Replace with your homepage widget
                            ),
                          );
                        },
                      )
                    : TextButton(
                        onPressed: () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
