import 'package:belajar_flutter/controllers/presensi.controller.dart';
import 'package:belajar_flutter/wigets/bottom_navigation.dart';
import 'package:belajar_flutter/wigets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:belajar_flutter/models/bulan_model.dart';

class Presensi extends StatelessWidget {
  final PresensiController presensiController = Get.put(PresensiController());

  Presensi({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: Obx(() {
              if (presensiController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rekapitulasi Kehadiran',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'Hadir',
                                count:
                                    '${presensiController.countKeterangan('m')}',
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'Terlambat',
                                count: presensiController.sumTerlambat(),
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'P. Cepat',
                                count: presensiController.sumPulang(),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'Sakit',
                                count:
                                    '${presensiController.countKeterangan('S')}',
                                color: Colors.brown,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'Cuti',
                                count:
                                    '${presensiController.countKeterangan('c')}',
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'Izin',
                                count:
                                    '${presensiController.countKeterangan('1')}',
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AttendanceSummaryCard(
                                title: 'Alpha',
                                count:
                                    '${presensiController.countKeterangan('A')}',
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          'Periode:',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Obx(() {
                              if (presensiController.isDropdownLoading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return DropdownButton<String>(
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  items: presensiController.katbulList
                                      .map((BulanModel bulan) {
                                    return DropdownMenuItem<String>(
                                      value: bulan.bulan,
                                      child: Text(bulan.bulan),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      presensiController.selectedBulan.value =
                                          newValue;
                                      presensiController
                                          .fetchPresensiDataByBulan(newValue);
                                    }
                                  },
                                  value: presensiController
                                          .selectedBulan.value.isEmpty
                                      ? null
                                      : presensiController.selectedBulan.value,
                                );
                              }
                            }),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Rekap Presensi Bulan Ini',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return ListView(
                                padding: const EdgeInsets.all(5),
                                children: [
                                  DataTable(
                                    columns: const [
                                      DataColumn(label: Text('No')),
                                      DataColumn(label: Text('Tanggal')),
                                      DataColumn(label: Text('Ket.')),
                                      DataColumn(label: Text('Telat')),
                                      DataColumn(label: Text('Telat')),
                                    ],
                                    columnSpacing: constraints.maxWidth * 0.1,
                                    rows: presensiController
                                            .presensiList.isEmpty
                                        ? [
                                            const DataRow(
                                              cells: [
                                                DataCell(
                                                  Text(
                                                    'Data belum tersedia',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  placeholder: true,
                                                ),
                                                DataCell(SizedBox.shrink(),
                                                    placeholder: true),
                                                DataCell(SizedBox.shrink(),
                                                    placeholder: true),
                                                DataCell(SizedBox.shrink(),
                                                    placeholder: true),
                                                DataCell(SizedBox.shrink(),
                                                    placeholder: true),
                                              ],
                                            ),
                                          ]
                                        : List<DataRow>.generate(
                                            presensiController
                                                .presensiList.length,
                                            (index) {
                                              var presensi = presensiController
                                                  .presensiList[index];
                                              return DataRow(
                                                cells: [
                                                  DataCell(Text(
                                                      (index + 1).toString())),
                                                  DataCell(
                                                      Text(presensi.tanggal)),
                                                  DataCell(Text(
                                                      presensi.keterangan)),
                                                  DataCell(Text(
                                                      '${presensi.terlambat} m')),
                                                  DataCell(Text(
                                                      '${presensi.cepat} m')),
                                                ],
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class AttendanceSummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const AttendanceSummaryCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
