import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoPage extends StatefulWidget {
  final String phoneNumber;
  final String countryCode;
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
            const SnackBar(content: Text('User not logged in')),
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
          SnackBar(content: Text('Failed to save user data: $e')),
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
                "Tell Us About You",
                style: midTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: maincolor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              Text(
                "Fill in your info to continue.",
                style: midTextStyle.copyWith(
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
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.person_outline, color: maincolor),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your first name' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.person_outline, color: maincolor),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your last name' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: gender,
                        hint: const Text("Select Gender"),
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.wc_outlined, color: maincolor),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'male', child: Text('Male')),
                          DropdownMenuItem(
                              value: 'female', child: Text('Female')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select your gender' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.email_outlined, color: maincolor),
                        ),
                        validator: (value) => !value!.contains('@')
                            ? 'Enter a valid email'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon:
                              Icon(Icons.phone_outlined, color: maincolor),
                        ),
                        validator: (value) =>
                            value!.length < 8 ? 'Enter a valid number' : null,
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
                  'Continue',
                  style: midTextStyle.copyWith(
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
                  'By continuing you agree to our Terms & Conditions',
                  style: midTextStyle.copyWith(
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
