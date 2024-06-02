import 'package:doc_app/Screens/auth/Login_Page.dart';
import 'package:doc_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DoctorHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                            AuthController().signout();
                            Get.offAll(LoginPage());
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome, Doctor!'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/doctor_appointments');
                },
                child: Text('View Appointments'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
