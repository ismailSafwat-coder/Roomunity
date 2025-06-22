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
          child: Image.network(
            'https://c1.wallpaperflare.com/preview/301/359/649/hanoi-street-nice-water-scene-home.jpg', // تأكد من وجود الصورة في المسار الصحيح
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        const Positioned(
          bottom: 200, // المسافة من الأسفل
          child: Column(
            children: [
              Text(
                'Join, connect, and level up',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 216, 210, 210),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Join the experience',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 216, 210, 210),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
