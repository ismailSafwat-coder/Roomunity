import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/core/constent.dart';
import 'package:roomunity/main.dart';

import 'package:roomunity/generated/l10n.dart';
import 'package:roomunity/pages/cheatpage.dart';
import 'package:roomunity/pages/studyrings/firstpage.dart';

import 'package:roomunity/widgets/search.dart';

import '';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<String> filteredItems = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundcolor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 300,
              backgroundColor: Colors.transparent,
              // remove default back button
              automaticallyImplyLeading: false,
              // bell icon on the right
              actions: const [],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // your background image
                    Image.network(
                      'https://c4.wallpaperflare.com/wallpaper/102/301/250/arabia-city-lights-night-wallpaper-preview.jpg',
                      fit: BoxFit.cover,
                    ),
                    // dark overlay to make text pop
                    Container(color: Colors.black38),
                    // greeting & subtitle
                    Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 20, bottom: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                    'images/Roomunity1.png', // Replace with your profile image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).welcome,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      S.of(context).travel,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              padding: const EdgeInsets.only(bottom: 15),
                              icon: const Icon(Icons.notifications_none,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ],
                        )),
                    // bottom-right location label
                    Positioned(
                      bottom: 80,
                      right: 16,
                      child: Text(
                        S.of(context).location,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // the white search bar nipped into the bottom of the appbar
              bottom: const SearchAppBar(), toolbarHeight: 0, titleSpacing: 0,
              floating: true,
              collapsedHeight: 0,
            ),

            // Kingdom Center Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).studeyRings,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Popular Cities
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCityCard(S.of(context).king_saud_university,
                              "https://static.hiamag.com/styles/1000x1000/public/featured/2017/10/02/6016796-1839130560.jpg"),
                          const SizedBox(width: 20),
                          _buildCityCard(
                              S.of(context).king_abdulaziz_university,
                              "https://static.srpcdigital.com/styles/1037xauto/public/2024-11/855790_0.jpeg.webp"),
                          const SizedBox(width: 20),
                          _buildCityCard(S.of(context).king_fahd_university,
                              "https://www.alluniversity.info/img/uni/0/logo-4751.png"),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Now in More Cities
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).services,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 300,
                      child: SizedBox(
                        height: 300,
                        child: Wrap(
                          spacing: devicewidth * 0.06,
                          runSpacing: 10,
                          children: [
                            _buildServiceCard(
                                S.of(context).cars, Icons.directions_car),
                            _buildServiceCard(
                                S.of(context).books_and_notes, Icons.menu_book),
                            _buildServiceCard(
                                S.of(context).child_care, Icons.child_care),
                            _buildServiceCard(S.of(context).hospital_assistance,
                                Icons.local_hospital),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Units That Fit Your Vibe
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Councils,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildPropertyCard(
                              S.of(context).football,
                              "https://media.gemini.media/img/Medium/2018/11/30/2018_11_30_17_50_4_426.jpg",
                              'football'),
                          _buildPropertyCard(
                              S.of(context).pubg,
                              "https://cdn1.epicgames.com/spt-assets/53ec4985296b4facbe3a8d8d019afba9/pubg-battlegrounds-19vwb.jpg",
                              'pubg'),
                          _buildPropertyCard(
                              S.of(context).baloot,
                              "https://pbs.twimg.com/media/DSVHfm9WsAAFXqc.jpg",
                              'baloot'),
                          _buildPropertyCard(
                              S.of(context).walkway,
                              "https://static.webteb.net/images/content/slideshowslide_sss_5497_570d5c26ac9-e729-4dd7-9976-64f59bb6b422.jpg",
                              'walkway'),
                          _buildPropertyCard(
                              S.of(context).chess,
                              "https://c4.wallpaperflare.com/wallpaper/414/915/652/macro-chess-figure-wallpaper-preview.jpg",
                              'chess'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // padding: const EdgeInsets.all(10),
                  // عرض ثابت لكل البطاقات
                  height: 250,
                  margin:
                      const EdgeInsets.only(right: 15), // مسافة بين البطاقات
                  child: Container(
                    height: 180, // ارتفاع ثابت لصورة البطاقة
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.blue[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJclTDicauH5K7qpNurpLOplC913YQk4bFvg&s",
                        fit: BoxFit.cover, // لتغطية المساحة المحددة
                        width: double.infinity, // ليملأ العرض بالكامل
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Bottom Navigation Bar
      ),
    );
  }

  Widget _buildCityCard(String name, String url) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Firstpage(university: name, url: url)));
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(url),
            // foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            radius: 50,
          ),
          Text(name)
        ],
      ),
    );
  }

  Widget _buildPropertyCard(String name, String url, String id) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupChatPage(
                      roomName: name,
                      roomId: id,
                    )));
      },
      child: Container(
        // padding: const EdgeInsets.all(10),
        width: 280, // عرض ثابت لكل البطاقات
        height: 250,
        margin: const EdgeInsets.only(right: 15), // مسافة بين البطاقات
        child: Column(
          children: [
            Container(
              height: 180, // ارتفاع ثابت لصورة البطاقة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  url,
                  fit: BoxFit.cover, // لتغطية المساحة المحددة
                  width: double.infinity, // ليملأ العرض بالكامل
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: commonTextStyle,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String name, IconData? icon) {
    return SizedBox(
      width: 160, // Adjusted width to allow two items per row

      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Icon(
                icon,
                size: 60,
                // color: Colors.greenAccent[400],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: commonTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCityGridCard(String name) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue[100],
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
