import 'package:belajar_flutter/controllers/user_controller.dart';
import 'package:belajar_flutter/wigets/bottom_navigation.dart';
import 'package:belajar_flutter/wigets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profil extends StatelessWidget {
  Profil({super.key});

  final UserController controller = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    // Fetch user data once the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserData();
    });

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
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.user.value != null) {
              final fotoUrl = controller.user.value!.userModel.foto
                      ?.replaceAll(' ', '%20') ??
                  'assets/images/logo.png';
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(fotoUrl,
                            headers: {"Content-Type": "image/jpeg"}),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        controller.user.value!.userModel.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        controller.user.value!.userModel.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildCategoryContainer('Informasi Pribadi', [
                      _buildInfoRowWithAlignedColon(
                          'NIK', controller.user.value?.nik),
                      _buildInfoRowWithAlignedColon(
                        'TTL',
                        [
                          if (controller.user.value?.tempat != null)
                            '${controller.user.value?.tempat}',
                          if (controller.user.value?.tglLahir != null)
                            '${controller.user.value?.tglLahir}',
                        ].join(', '),
                      ),
                      _buildInfoRowWithAlignedColon(
                        'JK',
                        [
                          if (controller.user.value?.jk == "P") 'Perempuan',
                          if (controller.user.value?.jk == "L") 'Laki-Laki',
                        ].join(''),
                      ),
                      _buildInfoRowWithAlignedColon(
                          'Agama', controller.user.value?.agama),
                    ]),
                    const SizedBox(height: 16),
                    _buildCategoryContainer('Kontak Pribadi', [
                      _buildInfoRowWithAlignedColon(
                          'WhatsApp', controller.user.value?.wa),
                      _buildInfoRowWithAlignedColon(
                          'E-mail', controller.user.value?.email),
                      _buildInfoRowWithAlignedColon(
                          'Lulusan',
                          [
                            controller.user.value?.pendidikan,
                            controller.user.value?.prodi,
                          ].join(' - ')),
                      _buildInfoRowWithAlignedColon(
                          'Perguruan', controller.user.value?.perguruan),
                      _buildInfoRowWithAlignedColon(
                          'Thn Lulus', controller.user.value?.thnLulus),
                    ]),
                    const SizedBox(height: 16),
                    _buildCategoryContainer('Detail Pekerjaan', [
                      _buildInfoRowWithAlignedColon(
                          'NUPTK', controller.user.value?.nuptk),
                      _buildInfoRowWithAlignedColon(
                          'Posisi', controller.user.value?.jabatan),
                      _buildInfoRowWithAlignedColon(
                          'Unit', controller.user.value?.unit),
                      _buildInfoRowWithAlignedColon(
                          'Mulai Tugas', controller.user.value?.mulaiTugas),
                    ]),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No user data'));
            }
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.fetchUserData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildCategoryContainer(String title, List<TableRow> rows) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FixedColumnWidth(16),
              2: FlexColumnWidth(),
            },
            children: rows,
          ),
        ],
      ),
    );
  }

  TableRow _buildInfoRowWithAlignedColon(String title, dynamic value) {
    String displayValue = value != null ? value.toString() : '-';

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Icon(
                Icons.arrow_right,
                color: Colors.blueAccent,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            ':',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            displayValue,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
