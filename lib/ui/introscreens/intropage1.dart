import 'package:flutter/material.dart';

class Intropage1 extends StatelessWidget {
  const Intropage1({super.key});

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
            'https://c0.wallpaperflare.com/preview/301/879/586/berlin-germany-oderberger-stra%C3%9Fe-aesthetic.jpg', // تأكد من وجود الصورة في المسار الصحيح
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        const Positioned(
          bottom: 200, // المسافة من الأسفل
          child: Column(
            children: [
              Text(
                'your home journey starts here',
                style: TextStyle(
                  fontFamily: 'PlaypenSansArabic',
                  fontSize: 24,
                  color: Color.fromARGB(255, 216, 210, 210),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Find your space',
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
