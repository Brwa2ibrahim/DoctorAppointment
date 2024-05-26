import 'package:doc_app/consts/colors.dart';
import 'package:doc_app/widgets/logo.dart';
import 'package:doc_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const logoApp(),
          Text(
            'Reset password',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            'Please Enter Your Email',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          CustomField(
            icon: Iconsax.direct,
            lable: "Email",
            controller: emailCon,
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                backgroundColor: AppColors.colMain,
                padding: EdgeInsets.all(16)),
            child: Center(
              child: Text(
                "Send Email".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }
}
