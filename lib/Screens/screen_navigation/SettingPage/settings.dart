import 'package:doc_app/Screens/auth/Login_Page.dart';
import 'package:doc_app/controllers/auth_controller.dart';
import 'package:doc_app/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: AssetImage('assets/images/doctor_profile.png'), // Placeholder image
                            ),
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Iconsax.edit4),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: ListTile(
                          leading: Icon(Iconsax.user_octagon),
                          title: Text(controller.username.value),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Iconsax.location),
                          title: Text(controller.location.value),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(Iconsax.user_octagon),
                          title: Text(controller.email.value),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () async {
                            AuthController().signout();
                            Get.offAll(LoginPage());
                          },
                          title: Text("Signout"),
                          trailing: Icon(Iconsax.logout_1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
