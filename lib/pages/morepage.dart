import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/generated/l10n.dart';
import 'package:roomunity/main.dart';
import 'package:roomunity/providers/language.dart';
import 'package:roomunity/ui/auth/loginscreen.dart';
import 'package:roomunity/widgets/custombuttom.dart';

class Morepage extends StatefulWidget {
  const Morepage({super.key});

  @override
  State<Morepage> createState() => _MorepageState();
}

class _MorepageState extends State<Morepage> {
  bool walletRecord = false;
  bool rateUs = true;

  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _fetchUserData();
      getgender();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future getgender() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        final data = snapshot.data() as Map<String, dynamic>;
        gender = data['gender'] ?? 'guest';
      }
    }
    setState(() {});
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (snapshot.exists) {
        userData = snapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      // المستخدم غير مسجل الدخول
      return Scaffold(
        backgroundColor: backgroundcolor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_outline, size: 100, color: Colors.grey),
                const SizedBox(height: 20),
                Text(
                  S.of(context).login_required_message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 30),
                Custombuttom(
                  text: S.of(context).login_now,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Loginscreen()),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    // المستخدم مسجل الدخول
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: ListView(
        children: [
          const SizedBox(height: 20),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: myColors[1],
                  backgroundImage: const AssetImage('images/Roomunity1.png'),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData?['firstName'] ?? "User",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      S.of(context).view_profile,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Options
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildListItem(
                  icon: Icons.account_balance_wallet,
                  title: S.of(context).wallet_record,
                  isChecked: walletRecord,
                  onChanged: (value) => setState(() => walletRecord = value!),
                ),
                _buildListItem(
                  icon: Icons.star_rate,
                  title: S.of(context).rate_us,
                  isChecked: rateUs,
                  onChanged: (value) => setState(() => rateUs = value!),
                ),
                _buildListItem(
                    icon: Icons.add_home_work,
                    title: S.of(context).host_with_us),
                _buildListItem(
                    icon: Icons.payment, title: S.of(context).payment_methods),
                _buildListItem(
                    icon: Icons.contact_support,
                    title: S.of(context).contact_us),
                _buildListItem(
                    icon: Icons.people_alt,
                    title: S.of(context).invite_friends),
                _buildListItem(
                    icon: Icons.question_answer, title: S.of(context).faq),
                _buildListItem(
                    icon: Icons.description, title: S.of(context).terms_of_use),
                _buildListItem(
                    icon: Icons.privacy_tip,
                    title: S.of(context).privacy_policy),
                _buildListItem(
                  icon: Icons.logout,
                  title: S.of(context).logout,
                  isLogout: true,
                ),
                IconButton(
                  icon: const Icon(Icons.language),
                  onPressed: () {
                    Provider.of<LocaleProvider>(context, listen: false)
                        .toggleLocale();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    bool isChecked = false,
    bool isLogout = false,
    ValueChanged<bool?>? onChanged,
  }) {
    return GestureDetector(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Loginscreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : myColors[1],
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.black,
              fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          trailing: onChanged != null
              ? Checkbox(
                  value: isChecked,
                  onChanged: onChanged,
                  activeColor: myColors[1],
                )
              : const Icon(Icons.chevron_right, color: Colors.grey),
        ),
      ),
    );
  }
}
