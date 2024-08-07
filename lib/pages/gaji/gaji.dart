import 'package:belajar_flutter/wigets/bottom_navigation.dart';
import 'package:belajar_flutter/wigets/navbar.dart';
import 'package:flutter/material.dart';

class Gaji extends StatelessWidget {
  const Gaji({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Navbar(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
