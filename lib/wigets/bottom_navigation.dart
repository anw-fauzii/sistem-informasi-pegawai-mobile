import 'package:belajar_flutter/controllers/authentication.dart';
import 'package:belajar_flutter/pages/dashboard.dart';
import 'package:belajar_flutter/pages/profil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationController authController = Get.find();
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
      currentIndex: 0,
      selectedItemColor: Colors.blue[900],
      onTap: (index) {
        if (index == 2) {
          authController.logout();
        } else if (index == 1) {
          Get.offAll(() => Profil());
        } else if (index == 0) {
          Get.offAll(() => const Dashboard());
        }
      },
    );
  }
}
