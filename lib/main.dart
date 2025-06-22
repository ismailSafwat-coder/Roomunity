import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/pages/morepage.dart';
import 'package:roomunity/ui/auth/formpage.dart';
import 'package:roomunity/ui/auth/loginscreen.dart';
import 'package:roomunity/ui/auth/otppage.dart';
import 'package:roomunity/ui/auth/phone.dart';

import 'package:roomunity/uitest/phonescreen1.dart';
import 'package:roomunity/ui/introscreens/mainintropage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

String gender = 'gest'; //
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(
        "height =${MediaQuery.sizeOf(context).height}   &&width = ${MediaQuery.sizeOf(context).width}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roomunity',
      theme: ThemeData(
        fontFamily: 'PlaypenSansArabic',
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: AnimatedSplashScreen(
      //   splash: "images/introqhd.gif",
      //   centered: true,
      //   splashIconSize: 2000,
      //   duration: 7000,
      //   nextScreen: const Loginscreen(),
      //   backgroundColor: Colors.black,
      // ), // Change this to '/intro' for the intro screen
      // Change this to MainIntroPage() for the intro screen
      home: const Mainpage(),
      routes: {
        '/login': (context) => const Loginscreen(),
        '/phonescreen': (context) => const PhonePage(),
        '/formpage': (context) => const UserInfoPage(),
        '/home': (context) => const Mainpage(),
        '/intro': (context) => const Mainintropage(),
      },
    );
  }
}
