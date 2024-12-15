import 'dart:io';

import 'package:dtc/consts/colors.dart';
import 'package:dtc/consts/images.dart';
import 'package:dtc/consts/strings.dart';
import 'package:dtc/controller/profile_controller.dart';
import 'package:dtc/widgets/custom_textfield.dart';
import 'package:dtc/widgets/our_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 30.heightBox,
            controller.profileImgPath.isEmpty
                ? Image.asset(
                    appLogo,
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                : Image.file(
                    File(controller.profileImgPath.value),
                    width: 100,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
            20.heightBox,
            ourButton(
                color: Colors.blueAccent.shade700,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            Divider(
              color: Colors.white,
            ),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: ('Your Name'),
                title: name,
                isPass: false),
            customTextField(
                controller: controller.passController,
                hint: ('Your Password'),
                title: password,
                isPass: true),
            20.heightBox,
            SizedBox(
              width: context.screenWidth - 60,
              height: 40,
              child: ourButton(
                  color: Colors.blueAccent.shade700,
                  onPress: () {},
                  textColor: whiteColor,
                  title: "Save"),
            ),
            15.heightBox,
          ],
        )
            .box
            .color(Colors.lightBlueAccent)
            .shadowMax
            .padding(EdgeInsets.all(16.0))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    );
  }
}
