import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_o_deals/Controller/auth/provider/login_.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;
  final Function(String) onCodeEntered;

  const VerifyOtp(
      {Key? key, required this.verificationId, required this.onCodeEntered})
      : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verify OTP')),
      body: Column(
        children: [
          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter OTP'),
          ),
          Consumer<logProvider>(
            builder: (context, value, child) => ElevatedButton(
              onPressed: () {
                widget.onCodeEntered(_otpController.text);
                value.setLoginStatus(true);
              },
              child: Text('Verify'),
            ),
          ),
        ],
      ),
    );
  }
}
