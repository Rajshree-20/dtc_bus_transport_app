import 'package:dtc/consts/consts.dart';
import 'package:dtc/controller/home_controller.dart';
import 'package:dtc/views/home_screen/user_home_screen/passAndTicket/pass&tickets.dart';
import 'package:dtc/views/home_screen/user_home_screen/profile_screen/profile.dart';
import 'package:dtc/views/suggestion/suggestion_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'home.dart';

class UserHomeScreen extends StatelessWidget{
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());

    var navbarItem =[
      BottomNavigationBarItem(icon: Image.asset(nearbyStops,width: 35,),label: 'Nearby Stops'),
      BottomNavigationBarItem(icon: Image.asset(passTickets,width: 35,),label: 'Pass & Tickets'),
      BottomNavigationBarItem(icon: Image.asset(suggestion,width: 35,),label: 'Suggestion'),
      BottomNavigationBarItem(icon: Image.asset(profile,width: 35,),label: 'Profile'),
    ];

    var navBody = [
      const HomeScreen(),
      PassAndTickets(),
      const SuggestionScreen(),
      const ProfileScreen()
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(
                  ()=> Expanded(child: navBody.elementAt(controller.currentnavIndex.value))
          ),
        ],
      ),
      bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currentnavIndex.value,
            selectedItemColor: Colors.blueAccent,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: navbarItem,
            onTap: (value){
              controller.currentnavIndex.value = value;
            },
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.0,
              )
          ),
      ),
    );
  }
}