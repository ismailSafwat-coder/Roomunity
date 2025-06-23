import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roomunity/pages/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:roomunity/ui/auth/formpage.dart';

class OtpPage extends StatefulWidget {
  final int phoneNumber;
  final String countryCode;
  final String verificationId;
  const OtpPage(
      {super.key,
      required this.phoneNumber,
      required this.countryCode,
      required this.verificationId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _start = 60;
  bool _isResendEnabled = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          _isResendEnabled = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _submitOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length != 6) {
      setState(() {
        _errorMessage = "Please enter a valid 6-digit code.";
        _isLoading = false;
      });
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      //add here if he have date on firestore go to main page

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final uid = user.uid;

        final doc = await FirebaseFirestore.instance
            .collection('users') // اسم التجميعة حسب مشروعك
            .doc(uid)
            .get();

        if (doc.exists) {
          // المستخدم لديه بيانات ⇒ انتقل إلى MainPage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const Mainpage()),
          );
        } else {
          // المستخدم لا يملك بيانات ⇒ انتقل إلى صفحة تعبئة البيانات (مثلاً FormPage)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => UserInfoPage(
                      phoneNumber: widget.phoneNumber.toString(),
                      countryCode: widget.countryCode,
                    )),
          );
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Invalid OTP. Please try again.";
        _isLoading = false;
      });
    }
  }

  void _resendOtp() {
    setState(() {
      _start = 60;
      _isResendEnabled = false;
      _errorMessage = null;
      for (var c in _otpControllers) {
        c.clear();
      }
    });
    _startTimer();
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme.copyWith(
      primary: const Color(0xFF4CAF50), // ← الأخضر الرئيسي
      // onSurface: Colors.white, // نص أبيض على الخلفيات الداكنة
      // surface: const Color(0xFFE8F5E9),
    );
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: Navigator.of(context).pop,
                ),
                const SizedBox(height: 16),

                // Logo
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primary.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.lock_outline,
                      size: 48,
                      color: colorScheme.primary,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "OTP Verification",
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                      fontSize: 26,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                Text(
                  "We've sent you a code on",
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),

                Text(
                  "+${widget.countryCode} ${widget.phoneNumber}",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: SizedBox(
                          height: 64,
                          child: TextField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            onChanged: (value) => _onOtpChanged(index, value),
                            decoration: InputDecoration(
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.green.withOpacity(0.2),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                // Error Message
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _errorMessage!,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.redAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 24),

                // Progress Bar
                LinearProgressIndicator(
                  value: (_start / 60),
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _isResendEnabled ? colorScheme.primary : Colors.grey,
                  ),
                ),

                const SizedBox(height: 16),

                // Resend Button
                Align(
                  alignment: Alignment.center,
                  child: _isResendEnabled
                      ? TextButton.icon(
                          onPressed: _resendOtp,
                          icon: const Icon(Icons.refresh),
                          label: Text("Resend OTP",
                              style: textTheme.labelLarge
                                  ?.copyWith(color: colorScheme.primary)),
                        )
                      : Text(
                          "Resend OTP in 00:$_start",
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                ),

                const Spacer(),

                // Submit Button
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submitOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "VERIFY OTP",
                            style: textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
