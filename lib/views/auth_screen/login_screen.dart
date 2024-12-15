import 'package:dtc/consts/colors.dart';
import 'package:dtc/consts/images.dart';
import 'package:dtc/consts/strings.dart';
import 'package:dtc/controller/auth_controller.dart';
import 'package:dtc/views/auth_screen/signup_screen.dart';
import 'package:dtc/views/home_screen/user_home_screen/user_home_screen.dart';
import 'package:dtc/widgets/applogo_widgets.dart';
import 'package:dtc/widgets/our_btn.dart';
import 'package:flutter/material.dart';
import 'package:dtc/widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 90),
              applogoWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Log in to your Account',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: ('Enter Your Email'),
                          title: email,
                          isPass: false,
                          controller: controller.emailController),
                      customTextField(
                          hint: ('Enter Your Password'),
                          title: password,
                          isPass: true,
                          controller: controller.passwordController),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: Text(forgotPass))),
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  Colors.lightBlueAccent),
                            )
                          : ourButton(
                              color: Colors.blueAccent.shade700,
                              title: login,
                              textColor: whiteColor,
                              onPress: () async {

                                controller.isloading(true);

                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedIn);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserHomeScreen()));
                                  } else {
                                    controller.isloading(false);
                                  }
                                });
                              }).box.width(context.screenWidth - 50).make(),
                      const SizedBox(
                        width: 200,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.black45,
                                thickness: 1.5,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.black45,
                                thickness: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Create a New Account',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ourButton(
                          color: Colors.blueAccent.shade700,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          }).box.width(context.screenWidth - 50).make(),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Log in with',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            google,
                            width: 35,
                          ),
                        ),
                      )
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .make(),
                ),
              ),
              // SizedBox(
              //   width: 200,
              //   height: 200,
              //   child: Lottie.asset(
              //     loginAnimation,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
