import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/generated/l10n.dart';
import 'package:roomunity/main.dart' as main;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoPage extends StatefulWidget {
  final String? phoneNumber;
  final String? countryCode;
  const UserInfoPage(
      {super.key, required this.phoneNumber, required this.countryCode});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  late double screenHeight;
  late double screenWidth;

  String? gender;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() == true) {
      try {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).user_not_logged)),
          );
          return;
        }

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'email': emailController.text.trim(),
          'gender': gender,
          'phone': widget.phoneNumber,
          'countryCode': widget.countryCode,
          'fullPhone': '+${widget.countryCode}${widget.phoneNumber}',
          'createdAt': FieldValue.serverTimestamp(),
        });

        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${S.of(context).failed_save_user_data} $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
          padding:
              EdgeInsets.only(top: screenHeight * 0.024, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Hero
              Hero(
                tag: 'logo',
                child: Image.asset(
                  'images/Roomunity1.png',
                  height: 180,
                  width: 180,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                S.of(context).tell_us_about_you,
                style: main.midTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: maincolor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                S.of(context).fill_info_to_continue,
                style: main.midTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Form Fields Section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                          labelText: S.of(context).first_name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.person_outline, color: maincolor),
                        ),
                        validator: (value) => value!.isEmpty
                            ? S.of(context).enter_first_name
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: S.of(context).last_name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.person_outline, color: maincolor),
                        ),
                        validator: (value) => value!.isEmpty
                            ? S.of(context).enter_last_name
                            : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: gender,
                        hint: Text(S.of(context).select_gender),
                        decoration: InputDecoration(
                          labelText: S.of(context).gender,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.wc_outlined, color: maincolor),
                        ),
                        items: [
                          DropdownMenuItem(
                              value: 'male', child: Text(S.of(context).male)),
                          DropdownMenuItem(
                              value: 'female',
                              child: Text(S.of(context).female)),
                        ],
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                            main.gender = gender!;
                          });
                        },
                        validator: (value) => value == null
                            ? S.of(context).please_select_gender
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: S.of(context).email_address,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.email_outlined, color: maincolor),
                        ),
                        validator: (value) => !value!.contains('@')
                            ? S.of(context).enter_valid_email
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: S.of(context).phone_number,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.phone_outlined, color: maincolor),
                        ),
                        validator: (value) => value!.length < 8
                            ? S.of(context).enter_valid_number
                            : null,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Continue Button
              ElevatedButton(
                onPressed: () => _submitForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: maincolor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  shadowColor: maincolor.withOpacity(0.4),
                  elevation: 5,
                ),
                child: Text(
                  S.of(context).continueT,
                  style: main.midTextStyle.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Optional Footer
              TextButton(
                onPressed: () {},
                child: Text(
                  S.of(context).by_continuing,
                  style: main.midTextStyle.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
