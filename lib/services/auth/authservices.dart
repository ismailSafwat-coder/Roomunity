import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservices {
  // Get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? getcurrentuser() {
    return _firebaseAuth.currentUser;
  }

  // Sign in with Google
  Future<String> signinWithGoogle(BuildContext context) async {
    String res = 'Some errors occurred';
    try {
      // Force sign-out to always show account chooser
      // await _googleSignIn.signOut();
      // Start the Google sign-in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        return 'sing in canceled';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      await _firebaseAuth.signInWithCredential(credential);
      res = 'succeed';
    } on FirebaseAuthException catch (e) {
      // Handle error with Firebase authentication
      _showErrorDialog(
          context, e.message ?? 'An error occurred during Google Sign-In.');
    } catch (e) {
      _showErrorDialog(context, e.toString());
      print(e.toString());
    }
    return res;
  }

  // Sign out
  Future<void> singout() async {
    return await _firebaseAuth.signOut();
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
