import 'package:doc_app/Screens/auth/SignUp_Page.dart';
import 'package:doc_app/Screens/auth/forget_screen.dart';
import 'package:doc_app/consts/fonts.dart';
import 'package:doc_app/controllers/auth_controller.dart';
import 'package:doc_app/widgets/logo.dart';
import 'package:doc_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  final bool isDoctor;
  const LoginPage({super.key, this.isDoctor = false});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool isDoctor = false;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const logoApp(),
            Text(
              'welcome back',
              style: TextStyle(fontSize: 28, fontFamily: AppFont.robotoBold),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomField(
                    icon: Iconsax.direct,
                    lable: "Email",
                    controller: controller.emailcontroller,
                  ),
                  CustomField(
                    icon: Iconsax.password_check,
                    lable: "Password",
                    controller: controller.passwordcontroller,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SwitchListTile(
                    value: isDoctor,
                    onChanged: (newValue) {
                      setState(() {
                        isDoctor = newValue;
                      });
                    },
                    title: "Sign in as a doctor".text.make(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        child: const Text("Forget Password?"),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetScreen(),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await controller.loginUser(isDoctor); // Pass isDoctor flag
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        backgroundColor: AppColors.colMain,
                        padding: const EdgeInsets.all(16)),
                    child: const Center(
                      child: Text(
                        "LOGIN",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.all(16)),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                          (route) => false);
                    },
                    child: Center(
                      child: Text(
                        "CREATE ACCOUNT",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
