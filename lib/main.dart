import 'package:doc_app/Screens/auth/SignUp_Page.dart';
import 'package:doc_app/Screens/doctor_screen/appointmentScreenDoc.dart';
import 'package:doc_app/Screens/doctor_screen/doctor_home.dart';
import 'package:doc_app/controllers/appointment_controller.dart';
import 'package:doc_app/Screens/auth/Login_Page.dart';
import 'package:doc_app/layout.dart';
import 'package:doc_app/widgets/watting_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AppointmentController());
    return GetMaterialApp(
      home: WattingScreen(),
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUp(),
        '/user_home': (context) => LayoutPage(),
        '/doctor_home': (context) => DoctorHomeScreen(),
        '/doctor_appointments': (context) => DoctorAppointmentsScreen(),
      },
    );
  }
}
