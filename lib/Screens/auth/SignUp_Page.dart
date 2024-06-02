import 'package:doc_app/Screens/auth/Login_Page.dart';
import 'package:doc_app/Screens/screen_navigation/appointmentPage/appointments_page.dart';
import 'package:doc_app/controllers/auth_controller.dart';
import 'package:doc_app/layout.dart';
import 'package:doc_app/widgets/logo.dart';
import 'package:doc_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUp extends StatefulWidget {
  static const routName = "/RegisterScreen";
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedCity;

  var isDoctor = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                    (route) => false);
              },
              icon: Icon(Iconsax.logout_1))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const logoApp(),
            Text(
              'Create account',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            CustomField(
              icon: Iconsax.personalcard4,
              lable: "name",
              controller: controller.fullnamecontroller,
            ),
            CustomField(
              icon: Iconsax.direct,
              lable: "Email",
              controller: controller.emailcontroller,
            ),
            CustomField(
              icon: Iconsax.password_check,
              lable: "Password",
              controller: controller.passwordcontroller,
            ),
            DropdownButton<String>(
              value: selectedCity,
              hint: const Text("Select City"),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
              items: const <String>['Sulaimani', 'Hawler', 'Duhok']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SwitchListTile(
                value: isDoctor,
                onChanged: (newValue) {
                  setState(() {
                    isDoctor = newValue;
                  });
                }),
            Visibility(
              visible: isDoctor,
              child: Column(
                children: [
                  CustomField(
                    icon: Iconsax.personalcard4,
                    lable: "About",
                    controller: controller.aboutcontroller,
                  ),
                  CustomField(
                    icon: Iconsax.direct,
                    lable: "Category",
                    controller: controller.categorycontroller,
                  ),
                  CustomField(
                    icon: Iconsax.password_check,
                    lable: "Adrees",
                    controller: controller.addresscontroller,
                  ),
                  CustomField(
                    icon: Iconsax.personalcard4,
                    lable: "Phone",
                    controller: controller.phonecontroller,
                  ),
                  CustomField(
                    icon: Iconsax.direct,
                    lable: "Timing",
                    controller: controller.timingcontroller,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.signupUser(isDoctor);
                if (isDoctor) {
                  Get.offAll(() => ScheduleScreen());
                } else {
                  Get.offAll(() => LayoutPage());
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: EdgeInsets.all(16)),
              child: Center(
                child: Text(
                  "Create ".toUpperCase(),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
