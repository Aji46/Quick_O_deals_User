import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_o_deals/View/Pages/use_login/otp_screen.dart';
import 'package:quick_o_deals/View/Pages/use_login/user_login.dart';

class PhoneNumberProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();
  String selectedCountryCode = "+91"; // Default country code
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void updateCountryCode(String newCountryCode) {
    selectedCountryCode = newCountryCode;
    notifyListeners();
  }

  Future<void> signInWithPhoneNumber(BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "$selectedCountryCode${phoneController.text.trim()}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback will be triggered on Android devices that support instant verification
          await _signInWithCredential(credential, context);
        },
        verificationFailed: (FirebaseAuthException e) {
          _handleVerificationError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          // Navigate to a new screen to enter the SMS code
          _navigateToSMSCodeScreen(context, verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-retrieval timeout, you can handle this if needed
          print("Auto-retrieval timeout");
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
      print("User signed in: ${userCredential.user?.uid}");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => UserLogin())
      );
      
    } catch (e) {
      print("Error signing in with credential: $e");
      // Show an error message to the user
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
      builder: (context) => VerifyOtp( // Make sure the class name matches your implementation
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