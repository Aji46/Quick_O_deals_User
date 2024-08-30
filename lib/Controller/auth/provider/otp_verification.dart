import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_o_deals/View/Pages/use_login/user_login.dart';

class OtpVerificationProvider extends ChangeNotifier {
  final TextEditingController otpController = TextEditingController();
  String phoneNumber = '';
  String verificationId = '';

  Future<void> verifyOtp(BuildContext context) async {
    final otp = otpController.text.trim();

    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the OTP')),
      );
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      print("UserCredential: $userCredential");

      final User? user = userCredential.user;
      print("User: $user");
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'phoneNumber': user.phoneNumber,
            'createdAt': Timestamp.now(),
          });
        }

        // Navigate to the home page or the desired route
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => UserLogin())); // Replace with your desired route
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error verifying OTP. Please try again.')),
      );
      print("Verification ID: $verificationId");
print("OTP: $otp");
    }
  }

  void setVerificationDetails(String phoneNumber, String verificationId) {
    this.phoneNumber = phoneNumber;
    this.verificationId = verificationId;
    notifyListeners();
  }
}



// ***************************************************************************//
