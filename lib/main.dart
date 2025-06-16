import 'package:flutter/material.dart';
import 'package:roomunity/pages/homepage.dart';
import 'package:roomunity/ui/auth/formpage.dart';
import 'package:roomunity/ui/auth/loginscreen.dart';
import 'package:roomunity/ui/auth/phone.dart';
import 'package:roomunity/uitest/phonescreen1.dart';
import 'package:roomunity/ui/introscreens/mainintropage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:roomunity/uitest/mainintropage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Roomunity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:
          '/phonescreen', // Change this to '/intro' for the intro screen
      // Change this to MainIntroPage() for the intro screen
      // home: PhonePage(),
      routes: {
        '/login': (context) => const Loginscreen(),
        '/phonescreen': (context) => const PhonePage(),
        '/formpage': (context) => const UserInfoPage(),
        '/home': (context) => const Homepage(),
        '/intro': (context) => const Mainintropage(),
      },
    );
  }
}
