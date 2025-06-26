import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/pages/mainpage.dart';

class Custombuttom extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const Custombuttom({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5bba6f),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
