import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_app/Screens/auth/Login_Page.dart';
import 'package:doc_app/Screens/doctor_screen/doctor_screen.dart';
import 'package:doc_app/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var fullnamecontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  // Doctor controller
  var aboutcontroller = TextEditingController();
  var addresscontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var categorycontroller = TextEditingController();
  var timingcontroller = TextEditingController();

  Rx<UserCredential?> userCredential = Rx<UserCredential?>(null);
  var currentUser = FirebaseAuth.instance.currentUser;
  var isDoctor = false.obs;

  void isUserAlreadyLoggedIn() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var data = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        isDoctor.value = data.data()?['isDoctor'] ?? false;

        if (isDoctor.value) {
          Get.offAll(() => DoctorScreen());
        } else {
          Get.offAll(() => LayoutPage());
        }
      } else {
        Get.offAll(() => LoginPage());
      }
    });
  }

  Future<void> loginUser(bool isDoctor) async {
    userCredential.value = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text, password: passwordcontroller.text);

    if (userCredential.value != null) {
      isUserAlreadyLoggedIn();
    }
  }

  Future<void> signupUser(bool isDoctor) async {
    userCredential.value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text,
      password: passwordcontroller.text,
    );
    await storeUserData(userCredential.value!.user!.uid, fullnamecontroller.text,
        emailcontroller.text, isDoctor);
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> storeUserData(
      String uid, String fullname, String email, bool isDoctor) async {
    var store = FirebaseFirestore.instance
        .collection(isDoctor ? 'doctors' : 'users')
        .doc(uid);
    if (isDoctor) {
      await store.set({
        "docAbout": aboutcontroller.text,
        "docAdrees": addresscontroller.text,
        "docCategory": categorycontroller.text,
        "docPhone": phonecontroller.text,
        "docRating": 1,
        "docTiming": timingcontroller.text,
        "docName": fullname,
        "docEmail": email,
        "docId": FirebaseAuth.instance.currentUser?.uid
      });
    } else {
      await store.set({
        'fullname': fullname,
        'email': email,
      });
    }
  }
}
