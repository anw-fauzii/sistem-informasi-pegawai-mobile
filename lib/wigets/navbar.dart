import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(
      kToolbarHeight); // You can adjust the height if needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'SIPegawai',
        style: GoogleFonts.manrope(
          fontWeight: FontWeight.bold,
          fontSize: 20, // Adjust font size as needed
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
            radius: 25,
          ),
        )
      ],
    );
  }
}
