import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/ui/auth/formpage.dart';
import 'package:roomunity/ui/auth/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomunity/firebase_options.dart';
import 'package:roomunity/ui/introscreens/mainintropage.dart';
import 'generated/l10n.dart';
import 'package:roomunity/uitest/secoundpage.dart';

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

String gender = 'guest';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await fetchGender();

  runApp(const MyApp());
}

Future<void> fetchGender() async {
  final uid = FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) return;

  try {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      gender = doc.data()?['gender']?.toString().toLowerCase() ?? 'guest';
      print('Fetched gender: $gender');
    }
  } catch (e) {
    print('Error fetching gender: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceheight = MediaQuery.sizeOf(context).height;
    devicewidth = MediaQuery.sizeOf(context).width;
    return MaterialApp(
      locale: const Locale('en', 'ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Roomunity',
      theme: ThemeData(
        fontFamily: 'PlaypenSansArabic',
        useMaterial3: true,
      ),
      home:
          //  ApartmentListingScreen(),
          AnimatedSplashScreen(
              splash: "images/introqhd.gif",
              centered: true,
              splashIconSize: 2000,
              duration: 7000,
              backgroundColor: Colors.black,
              nextScreen: FirebaseAuth.instance.currentUser != null
                  ? const Mainpage()
                  : const Mainintropage()),
      routes: {
        '/login': (context) => const Loginscreen(),
        '/home': (context) => const Mainpage(),
        // أضف صفحات أخرى حسب الحاجة
      },
    );
  }
}
