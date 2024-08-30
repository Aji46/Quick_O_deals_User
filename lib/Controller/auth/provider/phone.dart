import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_o_deals/View/Pages/use_login/otp_screen.dart';
import 'package:quick_o_deals/View/widget/bottom_nav_bar/bottom%20_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+91"; // Default country code
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  void updateCountryCode(String newCountryCode) {
    selectedCountryCode = newCountryCode;
    notifyListeners();
  }

  Future<void> signInWithPhoneNumber(BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "$selectedCountryCode${phoneController.text.trim()}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _signInWithCredential(credential, context);
        },
        verificationFailed: (FirebaseAuthException e) {
          _handleVerificationError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to a new screen to enter the SMS code
          print("OTP sent to ${phoneController.text.trim()}");
          _navigateToSMSCodeScreen(context, verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout, you can handle this if needed
          print("Auto-retrieval timeout for verificationId: $verificationId");
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      print("Error during phone number verification: $e");
      // Show an error message to the user
    }
  }

Future<void> _signInWithCredential(PhoneAuthCredential credential, BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    _user = userCredential.user;
    print("User signed in: ${_user?.uid}");
    
    // Save user data to Firestore
    await _saveUserDataToFirestore();

    // Update shared preferences to indicate login status
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => MyHomePage())
    );
  } catch (e) {
    print("Error signing in with credential: $e");
    // Show an error message to the user
  }
}

  Future<void> _saveUserDataToFirestore() async {
    if (_user != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(_user!.uid);

      await userRef.set({
        'email': '', // Phone authentication doesn't provide an email
        'phoneNumber': _user!.phoneNumber ?? '',
        'profilePicture': '', // Phone authentication doesn't provide a profile picture
        'username': '', // Phone authentication doesn't provide a username
      }, SetOptions(merge: true));
    }
  }

  void _handleVerificationError(FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    } else {
      print('Verification failed. Error: ${e.message}');
    }
    // Show an error message to the user
  }

  void _navigateToSMSCodeScreen(BuildContext context, String verificationId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VerifyOtp(
          verificationId: verificationId,
          onCodeEntered: (String smsCode) async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: smsCode,
            );
            await _signInWithCredential(credential, context);
          },
        ),
      ),
    );
  }
}
