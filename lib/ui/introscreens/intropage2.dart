import 'package:flutter/material.dart';

class Intropage2 extends StatelessWidget {
  const Intropage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.27), // التعتيم هنا
            BlendMode.darken,
          ),
          child: Image.asset(
            'images/intropage2.jpg', // تأكد من وجود الصورة في المسار الصحيح
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        const Positioned(
          bottom: 200, // المسافة من الأسفل
          child: Text(
            'Welcome to Roomunity',
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 216, 210, 210),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
