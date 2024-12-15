import 'package:dtc/consts/consts.dart';
import 'package:dtc/controller/auth_controller.dart';
import 'package:dtc/controller/profile_controller.dart';
import 'package:dtc/views/home_screen/user_home_screen/profile_screen/edit_profile_screen.dart';
import 'package:dtc/views/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          children: [

            // Edit profile button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ).onTap(() {
                Get.to(() => const EditProfileScreen());
              }),
            ),



            // Center the profile photo with a border
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: 120, // Adjust as needed
                  height: 120, // Adjust as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.white,
                        width: 4), // Border color and width
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      appLogo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),



            // User details section in a detail card
            20.heightBox,
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Displaying the user name
                    "Anuja".text.fontFamily(semibold).size(18).make(),
                    const Divider(height: 20, color: Colors.grey), // Divider
                    // Displaying the user email
                    "anuja@gmail.com".text.size(20).make(),
                  ],
                ),
              ),
            ),
            20.heightBox,


            // Logout button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await Get.put(AuthController()).signoutMethod(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontFamily: semibold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
