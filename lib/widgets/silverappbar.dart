import 'package:flutter/material.dart';

class Silverappbar extends StatelessWidget {
  const Silverappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // This is the app bar that will be displayed at the top of the screen
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Silver App Bar'),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Roomunity1.png',
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.green),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 400,
                      color: Colors.deepPurple,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 400,
                      color: Colors.deepPurple,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 400,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
