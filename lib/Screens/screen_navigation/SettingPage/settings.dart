import 'dart:io';

import 'package:doc_app/Screens/auth/Login_Page.dart';
import 'package:doc_app/controllers/auth_controller.dart';
import 'package:doc_app/controllers/settings_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  Future<void> pickImage() async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (res != null) {
        await uploadImageToFirebase(File(res.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('failed to pick image: $e '),
        ),
      );
    }
  }

  String? imgaeUrl;
  Future<void> uploadImageToFirebase(File image) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("image/${DateTime.now().microsecondsSinceEpoch}.png");
      await reference.putFile(image).whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            content: Text('Upload success '),
          ),
        );
      });

      imgaeUrl = await reference.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('failed upload image: $e '),
        ),
      );
    }
  }

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
                              child: imgaeUrl == null
                                  ? Icon(Iconsax.personalcard2)
                                  : SizedBox(
                                      height: 200,
                                      child: ClipOval(
                                        child: Image.network(
                                          imgaeUrl!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: -5,
                              right: -5,
                              child: IconButton(
                                onPressed: () {
                                  pickImage();
                                },
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
