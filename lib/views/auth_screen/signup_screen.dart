import 'package:dtc/consts/colors.dart';
import 'package:dtc/consts/consts.dart';
import 'package:dtc/consts/strings.dart';
import 'package:dtc/controller/auth_controller.dart';
import 'package:dtc/views/home_screen/user_home_screen/user_home_screen.dart';
import 'package:dtc/widgets/applogo_widgets.dart';
import 'package:dtc/widgets/bg_widget.dart';
import 'package:dtc/widgets/custom_textfield.dart';
import 'package:dtc/widgets/our_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: context.screenHeight * 0.1,
              ),
              applogoWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Create Your account',
                style: TextStyle(
                    fontSize: 18, fontFamily: semibold, color: Vx.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Obx(
                      () => Column(
                    children: [
                      customTextField(
                          hint: ('Enter Your Name'),
                          title: name,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          hint: ('Enter Your Email'),
                          title: email,
                          controller: emailController,
                          isPass: false),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'or Register with a Phone Number',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ),
                      customTextField(
                          hint: ('New Password'),
                          title: password,
                          controller: passwordController,
                          isPass: true),
                      customTextField(
                          hint: ('Confirm Password'),
                          title: retypePass,
                          controller: passwordRetypeController,
                          isPass: true),
                      Row(
                        children: [
                          Checkbox(
                            value: isCheck,
                            checkColor: Colors.white,
                            activeColor: Colors.blueAccent,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          const WidthBox(10),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  TextSpan(
                                    text: "Terms and Conditions ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: regular),
                                  ),
                                  TextSpan(
                                    text: "& ",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: regular),
                                  ),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: regular),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      5.heightBox,
                      controller.isloading.value? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Colors.lightBlueAccent),
                      ):
                      ourButton(
                          color: isCheck == true
                              ? Colors.blueAccent.shade700
                              : Colors.grey.shade200,
                          title: createAcc,
                          textColor: whiteColor,
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                UserCredential? userCredential = await controller
                                    .signupMethod(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                );

                                if (userCredential != null) {
                                  await controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                  VxToast.show(context, msg: signUpSuccess);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                } else {
                                  VxToast.show(context, msg: "Sign up failed. Please try again.");
                                  controller.isloading(false);
                                }
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          }), // Passing the checkbox state
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ).onTap(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }),
                    ],
                  )
                      .box
                      .blue100
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadow5xl
                      .make(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class signUpBtn extends StatelessWidget {
  final bool isEnabled;

  const signUpBtn({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled
          ? () {
        // Add your signup logic here
      }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? Colors.blueAccent.shade700 : Colors.grey,
        // Color change based on enabled state
        disabledForegroundColor: Colors.grey.withOpacity(0.38),
        disabledBackgroundColor: Colors.grey.withOpacity(0.12),
        // Disabled color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ), // If not enabled, the button is disabled
      child: const Text(
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
