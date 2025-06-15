import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';

class Custombuttom extends StatelessWidget {
  const Custombuttom({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: maincolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         const Loginscreen(), // Replace with your login widget
        //   ),
        // );
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
