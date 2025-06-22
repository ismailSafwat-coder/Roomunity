import 'package:flutter/material.dart';

class Intropage3 extends StatelessWidget {
  const Intropage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.25), // التعتيم هنا
            BlendMode.darken,
          ),
          child: Image.network(
            'https://c1.wallpaperflare.com/preview/837/662/369/seminar-meeting-hotel-training.jpg', // تأكد من وجود الصورة في المسار الصحيح
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
                ' Learn together ',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 216, 210, 210),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Find your focus with learning circles',
                style: TextStyle(
                  fontSize: 22,
                  overflow: TextOverflow.visible,
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
