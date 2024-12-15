import 'package:dtc/consts/consts.dart';
import 'package:dtc/views/auth_screen/login_screen.dart';
import 'package:dtc/views/auth_screen/signup_screen.dart';
import 'package:dtc/views/home_screen/user_home_screen/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:dtc/consts/consts.dart';


Widget ourButton({onPress, color, textColor, String? title}){
  return ElevatedButton(onPressed:onPress
  , child: title!.text.color(textColor).make(),
    style: ElevatedButton.styleFrom(
      backgroundColor: color
    ),
  );
}





//BUTTON FOR WELCOME PAGE

class startJourney extends StatefulWidget {
  const startJourney({super.key});

  @override
  State<startJourney> createState() => _startJourneyState();
}

class _startJourneyState extends State<startJourney> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.shade700,
          padding: const EdgeInsets.all(12)
      ),
      child: const Text('Start Your Journey', style: TextStyle(
        color: Colors.white,
      )
      ),
    );
  }
}





//OTP GENERATOR FOR BOTH LOGIN AND SIGNUP PAGE

class otp_btn extends StatefulWidget {
  const otp_btn({super.key});

  @override
  State<otp_btn> createState() => _otp_btnState();
}

class _otp_btnState extends State<otp_btn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(onPressed: (){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.shade700,
          padding: const EdgeInsets.all(12),
        ), child: const Text('Generate OTP',
          style: TextStyle(
            color: Colors.white,
          ),),
      ),
    );
  }
}





//CREATE ACCOUNT BUTTON FOR SIGNUP PAGE

class createAcc_btn extends StatelessWidget {
  final bool isEnabled;

  const createAcc_btn({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: isEnabled
            ? () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.blueAccent.shade700 : Colors.grey,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ), // Disable the button if not enabled
        child: const Text(
          'Create Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


//CURRENT LOCATION BUTTON


class MyLocationButton extends StatelessWidget {
  final MapController controller;
  final String myLoc;  // Add this line to pass the icon path

  const MyLocationButton({
    super.key,
    required this.controller,
    required this.myLoc,  // Add this line to pass the icon path
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        GeoPoint userLocation = await controller.myLocation();
        await controller.moveTo(userLocation);
      },
      backgroundColor: Colors.white,
      child: Icon(Icons.location_on_outlined,size: 55,color: Colors.blueAccent.shade700,)
    );
  }
}


//OTP BUTTON FOR PROFILE SCREEN

class OtpButton extends StatelessWidget {
  final String otpType;
  final VoidCallback onOtpButtonPressed;

  const OtpButton({
    Key? key,
    required this.otpType,
    required this.onOtpButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onOtpButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.shade700,
          padding: const EdgeInsets.all(12),
        ),
        child: Text(
          'Generate OTP',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}