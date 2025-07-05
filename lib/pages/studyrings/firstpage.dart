import 'package:flutter/material.dart';
import 'package:roomunity/generated/l10n.dart';

class Firstpage extends StatefulWidget {
  final String university;
  final String url;

  const Firstpage({
    super.key,
    required this.university,
    required this.url,
  });

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildDecoratedTab(String text, int index, double width) {
    final bool isSelected = controller.index == index;
    return Tab(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.white, Colors.grey[100]!],
                ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 4))
                ]
              : null,
          border: Border.all(
            color: isSelected ? const Color(0xFF3366FF) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    return Scaffold(
      body: Column(
        children: [
          // Header with curved bottom and gradient
          Container(
            width: double.infinity,
            height: deviceHeight * 0.3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).welcom_to_you,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.university,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 32,
                            backgroundImage: NetworkImage(widget.url),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Tab bar
                    TabBar(
                      controller: controller,
                      indicatorColor: Colors.transparent,
                      tabs: [
                        _buildDecoratedTab(
                          'register',
                          0,
                          deviceWidth,
                        ),
                        _buildDecoratedTab(
                          'previous_files',
                          1,
                          deviceWidth,
                        ),
                        _buildDecoratedTab(
                          'save_schedule',
                          2,
                          deviceWidth,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Tab views with card-style content
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Register for a study group',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 8),
                              Text(
                                  'Fill in the form to join a study group for your courses.'),
                            ],
                          ),
                        ),
                      ),
                      // Add more cards or UI elements...
                    ],
                  ),
                ),
                const Center(child: Text('Previous Files Content')),
                const Center(child: Text('Save Schedule Content')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
