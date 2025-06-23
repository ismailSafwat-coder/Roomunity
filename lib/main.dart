import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/ui/auth/formpage.dart';
import 'package:roomunity/ui/auth/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomunity/firebase_options.dart';

String gender = 'guest'; // سيتم تعبئته لاحقًا من Firestore
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

  Future<Widget> checkUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final uid = user.uid;
      final snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data()!;
        gender = data['gender'] ?? 'guest';
        return const Mainpage(); // المستخدم لديه بيانات
      } else {
        return UserInfoPage(
          phoneNumber: user.phoneNumber?.replaceAll('+966', '') ?? '',
          countryCode: '966',
        ); // لا توجد بيانات → انتقل لصفحة إدخال البيانات
      }
    } else {
      return const Loginscreen(); // المستخدم غير مسجل دخول
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roomunity',
      theme: ThemeData(
        fontFamily: 'PlaypenSansArabic',
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: checkUser(),
        builder: (context, snapshot) {
          return AnimatedSplashScreen(
            splash: "images/introqhd.gif",
            centered: true,
            splashIconSize: 2000,
            duration: 4000,
            backgroundColor: Colors.black,
            nextScreen: snapshot.connectionState == ConnectionState.done
                ? snapshot.data ?? const Loginscreen()
                : const Scaffold(
                    backgroundColor: Colors.black,
                    body: Center(child: CircularProgressIndicator()),
                  ),
          );
        },
      ),
      routes: {
        '/login': (context) => const Loginscreen(),
        '/home': (context) => const Mainpage(),
        // أضف صفحات أخرى حسب الحاجة
      },
    );
  }
}
