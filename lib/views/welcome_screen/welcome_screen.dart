import 'dart:async';

import 'package:dtc/consts/animations.dart';
import 'package:dtc/views/auth_screen/login_screen.dart';
import 'package:dtc/views/home_screen/user_home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      final _auth = FirebaseAuth.instance;
      if (_auth.currentUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100, // Adjust width as needed
                  height: 100, // Adjust height as needed
                  child: Lottie.asset(
                    animation1, //
                  ),
                ),
                const Text(
                  'WELCOME TO DTC APP',
                  style: TextStyle(
                    color: Colors.black, // Change text color to black
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'DELHI TRANSPORT CORPORATION',
                  style: TextStyle(
                      color: Colors.black54, // Slightly lighter text color
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 300,
              child: Lottie.asset(
                busAnimation,
              ),
            ),
            const SizedBox(height: 20), // Adjust spacing between Lottie and button
          ],
        ),
      ),
    );
  }
}
