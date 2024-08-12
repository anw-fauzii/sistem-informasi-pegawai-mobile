import 'package:belajar_flutter/pages/Yaumiyah/yaumiyah.dart';
import 'package:belajar_flutter/pages/diklat/diklat.dart';
import 'package:belajar_flutter/pages/fasilitas/fasilitas.dart';
import 'package:belajar_flutter/pages/gaji/gaji.dart';
import 'package:belajar_flutter/pages/menu_utama.dart';
import 'package:belajar_flutter/pages/presensi/presensi.dart';
import 'package:belajar_flutter/pages/qrCode/qr_code.dart';
import 'package:belajar_flutter/wigets/bottom_navigation.dart';
import 'package:belajar_flutter/wigets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final user = box.read('user') ?? {};
    final userName = user['name'] ?? 'Guest';

    return Scaffold(
      appBar: const Navbar(),
      bottomNavigationBar: const BottomNavigation(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bgaa.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello! Selamat Datang",
                      style: GoogleFonts.manrope(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              letterSpacing: 1.0),
                        ),
                        const Icon(
                          Icons.waving_hand,
                          color: Colors.white,
                          size: 40,
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    const Row(
                      children: [
                        Expanded(
                            child: LinearProgressIndicator(
                          value: 0,
                          backgroundColor: Colors.white54,
                          minHeight: 5,
                        ))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text("Menu Utama",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => Presensi());
                    },
                    child: const MenuUtama(
                      title: "Presensi",
                      icon: Icon(
                        Icons.alarm_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const Diklat());
                    },
                    child: const MenuUtama(
                      title: "Diklat",
                      icon: Icon(
                        Icons.cases_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => Yaumiyah());
                    },
                    child: const MenuUtama(
                      title: "M. Yaumiyah",
                      icon: Icon(
                        Icons.menu_book_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const Fasilitas());
                    },
                    child: const MenuUtama(
                      title: "Fasilitas",
                      icon: Icon(
                        Icons.business_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const Gaji());
                    },
                    child: const MenuUtama(
                      title: "Slip Gaji",
                      icon: Icon(
                        Icons.monetization_on_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const QrCode());
                    },
                    child: const MenuUtama(
                      title: "QR Code",
                      icon: Icon(
                        Icons.qr_code_2,
                        size: 40,
                        color: Colors.white,
                      ),
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
