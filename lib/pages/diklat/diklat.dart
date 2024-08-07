import 'package:belajar_flutter/wigets/bottom_navigation.dart';
import 'package:belajar_flutter/wigets/navbar.dart';
import 'package:flutter/material.dart';

class Diklat extends StatelessWidget {
  const Diklat({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Navbar(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
