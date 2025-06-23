import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/ui/auth/formpage.dart';
import 'package:roomunity/ui/auth/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomunity/firebase_options.dart';
import 'package:roomunity/ui/introscreens/mainintropage.dart';

String gender = 'gest';
late double deviceheight;
late double devicewidth;

const TextStyle midTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
const TextStyle commonTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w500,
  color: Colors.black,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roomunity',
      theme: ThemeData(
        fontFamily: 'PlaypenSansArabic',
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const Mainpage()
          : AnimatedSplashScreen(
              splash: "images/introqhd.gif",
              centered: true,
              splashIconSize: 2000,
              duration: 7000,
              backgroundColor: Colors.black,
              nextScreen: const Mainintropage()),
      routes: {
        '/login': (context) => const Loginscreen(),
        '/home': (context) => const Mainpage(),
        // أضف صفحات أخرى حسب الحاجة
      },
    );
  }
}
