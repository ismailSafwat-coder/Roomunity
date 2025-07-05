import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:vector_icons/vector_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/main.dart';
import 'package:roomunity/pages/lovedpage.dart';
import 'package:roomunity/pages/mapspage.dart';
import 'package:roomunity/pages/morepage.dart';
import 'package:roomunity/pages/searchpage.dart';
import 'package:roomunity/pages/searchpage.dart';
import 'package:roomunity/widgets/silverappbar.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> pages = <Widget>[
    const Searchpage(),
    const LovedCardPage(),
    const Text(
      'Search',
      style: optionStyle,
    ),
    const Mapspage(),
    const Morepage()
  ];
  Future<void> fetchGender() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        gender = doc.data()?['gender']?.toString().toLowerCase() ?? 'guest';
        print('Fetched gender: $gender');
        setState(() {});
      }
    } catch (e) {
      print('Error fetching gender: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: myColors[0],
                  tabBackgroundColor: Colors.grey[200]!,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: LineIcons.heart,
                      text: 'Likes',
                    ),
                    GButton(
                      icon: LineIcons.search,
                      text: 'Search',
                    ),
                    GButton(
                      icon: LineIcons.map,
                      text: 'maps',
                    ),
                    GButton(
                      icon: LineIcons.horizontalEllipsis,
                      text: 'More',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        body: pages[_selectedIndex]);
  }
}
