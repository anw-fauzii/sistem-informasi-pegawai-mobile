import 'package:belajar_flutter/controllers/yaumiyah_controller.dart';
import 'package:belajar_flutter/models/yaumiyah_model.dart';
import 'package:belajar_flutter/wigets/bottom_navigation.dart';
import 'package:belajar_flutter/wigets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Yaumiyah extends StatelessWidget {
  Yaumiyah({super.key});

  final YaumiyahController controller = Get.put(YaumiyahController());

  @override
  Widget build(BuildContext context) {
    String currentDate =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentDate,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Obx(() {
                    return ListView(
                      children: controller.yaumiyahList.map((activity) {
                        return _buildActivityRow(activity);
                      }).toList(),
                    );
                  }),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () {
                      controller.saveData(); // Save data when button is pressed
                    },
                    child: const Text(
                      'Simpan',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(YaumiyahModel activity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.yaumiyah,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _getActivityIcon(activity.yaumiyah),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: activity.selectedValue,
                  items: const [
                    DropdownMenuItem(value: 'Ya', child: Text('Ya')),
                    DropdownMenuItem(value: 'Tidak', child: Text('Tidak')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateSelection(activity.id, value);
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white.withOpacity(0.9),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down_circle,
                      color: Colors.blue),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  dropdownColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getActivityIcon(String activityName) {
    IconData iconData;
    switch (activityName) {
      case 'Zikir Pagi':
        iconData = Icons.wb_sunny;
        break;
      case 'Tilawah':
        iconData = Icons.book;
        break;
      case 'Salat Duha':
        iconData = Icons.wb_cloudy;
        break;
      case 'Salat Rawatib':
        iconData = Icons.self_improvement;
        break;
      case 'Salat Berjamaah':
        iconData = Icons.people;
        break;
      case 'Zikir Sore':
        iconData = Icons.nightlight_round;
        break;
      case 'Haid':
        iconData = Icons.water_drop;
        break;
      default:
        iconData = Icons.check_circle;
    }
    return Icon(iconData, color: Colors.white, size: 24);
  }
}
