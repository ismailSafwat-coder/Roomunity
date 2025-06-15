// import 'package:ecommercerapp/pages/homepage.dart';
// import 'package:ecommercerapp/pages/singinorsingup_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Authgate extends StatelessWidget {
//   const Authgate({super.key});

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           // User is logged in
//           if (snapshot.hasData) {
//             return const Homepage();
//           }
//           // User not logged in
//           else {
//             return const SingInOrSinUpPage();
//           }
//         },
//       ),
//     );
//   }
// }
