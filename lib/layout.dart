import 'package:doc_app/Screens/screen_navigation/appointmentPage/appointments_page.dart';
import 'package:doc_app/Screens/screen_navigation/categoryPage/categoryPage.dart';
import 'package:doc_app/Screens/screen_navigation/homePage/home_screen.dart';
import 'package:doc_app/Screens/screen_navigation/SettingPage/settings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {

  int currentIndex = 0;
  PageController pageCon = PageController();
  @override
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
           PageView(
              onPageChanged: (value) => setState(() {
                currentIndex = value;
              }),
              controller: pageCon,
              children: [
                HomeScreen(),
                categoryPage(),
                ScheduleScreen(),
                SettingScreen(),
              ],
            ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => setState(() {
          currentIndex = value;
          pageCon.jumpToPage(value);
        }),
        elevation: 1,
        backgroundColor: Colors.white.withOpacity(0.2),
        selectedIndex: currentIndex,
        indicatorColor: Colors.greenAccent,
        destinations: [
          NavigationDestination(
            icon: Icon(Iconsax.home),
            label: "Home",
            selectedIcon: Icon(
              Iconsax.home,
              color: const Color.fromARGB(255, 241, 244, 242),
            ),
          ),
          NavigationDestination(
              icon: Icon(Iconsax.category), label: "Specialties"),
          NavigationDestination(
              icon: Icon(Iconsax.calendar5), label: "Appointments"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
