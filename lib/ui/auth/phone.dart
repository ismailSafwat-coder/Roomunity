import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roomunity/core/colors.dart';
import 'package:roomunity/main.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:roomunity/ui/auth/otppage.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late double width;
  late double height;
  Country selectedcountry = Country(
    phoneCode: '966',
    countryCode: 'SA',
    name: 'Saudi Arabia',
    e164Sc: 0,
    geographic: true,
    level: 1,
    example: '5X XXXX XXXX',
    displayName: 'Saudi Arabia',
    displayNameNoCountryCode: 'Saudi Arabia',
    e164Key: '',
  );

  final Map<String, int> countryPhoneLengths = {
    'EG': 10, // Egypt
    'SA': 9, // Saudi Arabia
    'IN': 10, // India
    'US': 10, // USA
    'AE': 9, // UAE
    // أضف الدول اللي عايز تدعمها
  };

  int getMinPhoneLength(Country country) {
    return countryPhoneLengths[country.countryCode] ??
        6; // افتراضيًا 6 خانات لو غير معروف
  }

  int getMaxPhoneLength(Country country) {
    return countryPhoneLengths[country.countryCode] ?? 15; // افتراضيًا 15 خانة
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      setState(() {}); // إعادة بناء الواجهة عند تغيير النص
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Roomunity',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Poppins',
            shadows: [
              Shadow(
                blurRadius: 5.0,
                offset: const Offset(2.0, 2.0),
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFF888F4B), // Main color
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 25),

            // Instruction Text
            const Text(
              'Enter your mobile number to create an account or log in',
              style: TextStyle(
                fontSize: 17,
                color: Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 40),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * 0.27,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                countryListTheme: CountryListThemeData(
                                    bottomSheetHeight: height * 0.65),
                                onSelect: (Country country) {
                                  setState(() {
                                    selectedcountry = country;
                                  });
                                },
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_drop_down_sharp,
                                    color: Colors.grey),
                                Text(
                                  '${selectedcountry.flagEmoji}+${selectedcountry.phoneCode}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: width * 0.62,
                  child: TextFormField(
                    controller: _phoneController,
                    maxLength: getMaxPhoneLength(selectedcountry),
                    decoration: InputDecoration(
                      suffixIcon: _phoneController.text.length >=
                              getMinPhoneLength(selectedcountry)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Enter your mobile number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: scoundrycolor,
              minWidth: width * 0.8,
              height: height * 0.07,
              onPressed: () async {
                if (_phoneController.text.isEmpty ||
                    _phoneController.text.length <
                        getMinPhoneLength(selectedcountry)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please enter a valid phone number')),
                  );
                  return;
                }

                final fullPhoneNumber =
                    '+${selectedcountry.phoneCode}${_phoneController.text.trim()}';

                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: fullPhoneNumber,
                  timeout: const Duration(seconds: 60),
                  verificationCompleted:
                      (PhoneAuthCredential credential) async {
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const Mainpage())); // Success
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Verification failed: ${e.message}')),
                    );
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtpPage(
                          phoneNumber: int.parse(_phoneController.text.trim()),
                          countryCode: selectedcountry.phoneCode,
                          verificationId: verificationId, // مهم جدًا
                        ),
                      ),
                    );
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: Text(
                'Login',
                style: midTextStyle.copyWith(color: Colors.white, fontSize: 25),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'we will send a SMS to entered number containing a verification code.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            const Text(
                'Make sure you have entered your phone number correctly.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
