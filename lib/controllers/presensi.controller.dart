// lib/controllers/presensi_controller.dart

import 'dart:convert';
import 'package:belajar_flutter/constants/constants.dart';
import 'package:get/get.dart';
import 'package:belajar_flutter/models/presensi_model.dart';
import 'package:belajar_flutter/models/bulan_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PresensiController extends GetxController {
  var presensiList = <PresensiModel>[].obs;
  var katbulList = <BulanModel>[].obs;
  var month = BulanModel(bulan: '').obs;
  var selectedBulan = ''.obs;
  var isLoading = true.obs;
  var isDropdownLoading = false.obs;

  @override
  void onInit() {
    fetchPresensiData();
    super.onInit();
  }

  void fetchPresensiData() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('$url/api/absen'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        presensiList.value = (data['data'] as List)
            .map((i) => PresensiModel.fromJson(i))
            .toList();

        katbulList.value = (data['katbul'] as List)
            .map((i) => BulanModel.fromJson(i))
            .toList();

        month.value = BulanModel.fromJson(data['month']);
      } else {
        Get.snackbar('Error', 'Failed to load data');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchPresensiDataByBulan(String bulan) async {
    try {
      isDropdownLoading(true);
      final response = await http.get(
        Uri.parse('$url/api/absen/$bulan'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        presensiList.value = (data['data'] as List)
            .map((i) => PresensiModel.fromJson(i))
            .toList();
      } else {
        Get.snackbar(
            'Error', 'Failed to load dataStatus code: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isDropdownLoading(false);
    }
  }

  void onBulanSelected(String? newValue) {
    if (newValue != null && newValue.isNotEmpty) {
      selectedBulan.value = newValue;
      fetchPresensiDataByBulan(newValue);
    }
  }

  int countKeterangan(String keterangan) {
    return presensiList
        .where((presensi) => presensi.keterangan == keterangan)
        .length;
  }

  String sumTerlambat() {
    int totalTerlambat = presensiList
        .map((presensi) => presensi.terlambat)
        .fold(0, (prev, element) => prev + element);

    return '$totalTerlambat m';
  }

  String sumPulang() {
    int totalPulang = presensiList
        .map((presensi) => presensi.cepat)
        .fold(0, (prev, element) => prev + element);
    return '$totalPulang m';
  }
}
