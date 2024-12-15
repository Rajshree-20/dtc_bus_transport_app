import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dtc/consts/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  // Text Controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.message ?? "Login failed. Please try again.");
    } catch (e) {
      VxToast.show(context, msg: "An unexpected error occurred.");
    }

    return userCredential;
  }

  // Signup method
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Storing user data method
  storeUserData({name, password, email}) async {
    DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
    });
  }

  // Signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();

      // Clear the text fields after logout
      emailController.clear();
      passwordController.clear();

      // Reset loading state
      isloading(false);

    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
