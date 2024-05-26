import 'package:flutter/material.dart';
import 'package:doc_app/controllers/auth_controller.dart';
import 'package:get/get.dart';

class WattingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    authController.isUserAlreadyLoggedIn();

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
