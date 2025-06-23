import 'package:flutter/material.dart';
import 'package:roomunity/main.dart';

var maincolor = const Color(0xFF888F4B);
var scoundrycolor = const Color(0xFFA9AC67);

Color backgroundcolor = gender == "gest"
    ? Colors.white
    : gender == "male"
        ? Colors.white
        : Colors.white;

List<Color> myColors = gender == 'Male'
    ? manecolor
    : gender == "gest"
        ? gest
        : womancolor;

List<Color> manecolor = [
  const Color(0xFF07c8f9),
  const Color(0xFF09a6f3),
  const Color(0xFF0a85ed),
  const Color(0xFF0c63e7),
  const Color(0xFF0d41e1),
];

List<Color> gest = [
  const Color(0xFF5bba6f),
  const Color(0xFF3fa34d),
  const Color(0xFF2a9134),
  const Color(0xFF137547),
  const Color(0xFF054a29),
];

List<Color> womancolor = [
  const Color(0xFFe27396),
  const Color(0xFFea9ab2),
  const Color(0xFFefcfe3),
  const Color(0xFFeaf2d7),
  const Color(0xFFb3dee2),
];
