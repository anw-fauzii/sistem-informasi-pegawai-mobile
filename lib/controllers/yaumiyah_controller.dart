import 'package:belajar_flutter/constants/constants.dart';
import 'package:belajar_flutter/models/yaumiyah_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class YaumiyahController extends GetxController {
  var yaumiyahList = <YaumiyahModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchYaumiyah();
  }

  void fetchYaumiyah() async {
    try {
      final response = await http.get(
        Uri.parse('$url/api/mutabaah-yaumiyah'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Pastikan 'yaumiyah' ada dan merupakan List
        if (data.containsKey('yaumiyah') && data['yaumiyah'] is List) {
          var yaumiyahData = data['yaumiyah'] as List;

          // Periksa apakah 'dataa' ada dan merupakan Map
          var yaumiyahStatus = <String, dynamic>{};
          if (data.containsKey('dataa') &&
              data['dataa'] is Map<String, dynamic>) {
            yaumiyahStatus = data['dataa'] as Map<String, dynamic>;
          }

          yaumiyahList.value = yaumiyahData.map((item) {
            String selectedValue = 'Tidak'; // Nilai default

            // Periksa apakah ada status untuk yaumiyah_id tertentu
            if (yaumiyahStatus.isNotEmpty &&
                yaumiyahStatus.containsKey(item['id'].toString())) {
              var status = yaumiyahStatus[item['id'].toString()];
              selectedValue = status['keterangan'] ?? 'Tidak';
            }

            return YaumiyahModel(
              id: item['id'],
              yaumiyah: item['yaumiyah'],
              selectedValue: selectedValue,
            );
          }).toList();
        } else {
          Get.snackbar('Error', 'Invalid response structure');
        }
      } else {
        Get.snackbar('Error', 'Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data: $e');
    }
  }

  void updateSelection(int id, String value) {
    int index = yaumiyahList.indexWhere((element) => element.id == id);
    if (index != -1) {
      yaumiyahList[index] = YaumiyahModel(
        id: yaumiyahList[index].id,
        yaumiyah: yaumiyahList[index].yaumiyah,
        selectedValue: value,
      );
    }
  }

  Future<void> saveData() async {
    var data = yaumiyahList.map((activity) {
      return {
        'id': activity.id,
        'selectedValue': activity.selectedValue,
      };
    }).toList();

    final response = await http.post(
      Uri.parse('$url/api/mutabaah-yaumiyah'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('token')}',
        'Content-Type': 'application/json',
      },
      body: json.encode({'yaumiyah': data}),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Data saved successfully!');
    } else {
      Get.snackbar('Error', 'Failed to save data: ${response.reasonPhrase}');
    }
  }
}
