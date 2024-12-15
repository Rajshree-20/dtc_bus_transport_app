import 'package:flutter/material.dart';
import 'package:dtc/views/auth_screen/login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String otpType;
  final String value;
  final VoidCallback onOtpVerified;

  const OtpScreen({
    Key? key,
    required this.otpType,
    required this.value,
    required this.onOtpVerified,
  }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();

  void _verifyOtp() {
    if (_otpController.text.length == 4) {
      widget.onOtpVerified(); // Notify parent widget that OTP is verified
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      // Show an error message if OTP is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter OTP for ${widget.otpType}", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("New ${widget.otpType}: ${widget.value}"), // Display new phone number or email
            SizedBox(height: 8),
            TextFormField(
              controller: _otpController,
              maxLength: 4,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                counterText: '',
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _verifyOtp,
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
