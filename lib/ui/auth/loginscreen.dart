import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/main.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/services/auth/authservices.dart';
import 'package:roomunity/ui/auth/phone.dart';
import 'package:roomunity/widgets/custombuttom.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Image

                Image.asset(
                  'images/Roomunity1.png',
                  height: 220,
                  width: 220,
                ),

                const SizedBox(height: 30),

                // Title Text
                Text(
                  'Welcome to Roomunity',
                  style: midTextStyle.copyWith(
                      fontSize: 26,
                      color: maincolor,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                Text(
                  'Sign in to continue',
                  style: midTextStyle.copyWith(
                      fontSize: 16, color: Colors.grey[700]),
                ),

                const SizedBox(height: 40),

                // Divider with OR text
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        'Login with',
                        style: midTextStyle.copyWith(
                            fontSize: 20, color: maincolor),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1.5,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Phone Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhonePage()));
                        },
                        icon: const Icon(Icons.phone,
                            size: 40, color: Colors.blue),
                      ),
                    ),

                    const SizedBox(width: 40),

                    // Google Button
                    GestureDetector(
                      onTap: () async {
                        String result =
                            await Authservices().signinWithGoogle(context);
                        if (result == 'succeed') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Mainpage(),
                            ),
                          );
                        }
                        print('Google Sign In Pressed');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          'images/google.svg',
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Optional: Add a small footer or policy text
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'By continuing you agree to our Terms & Conditions',
                    style:
                        midTextStyle.copyWith(fontSize: 12, color: Colors.grey),
                  ),
                ),

                Custombuttom(
                  text: "join as gest",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const Mainpage(), // Replace with your login widget
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
