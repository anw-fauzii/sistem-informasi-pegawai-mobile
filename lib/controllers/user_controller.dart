// user_controller.dart
import 'package:belajar_flutter/constants/constants.dart';
import 'package:belajar_flutter/models/karyawan_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController extends GetxController {
  var isLoading = false.obs;
  var user = Rx<KaryawanModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Memanggil fetchUserData saat controller diinisialisasi
  }

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$url/api/user-data'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );

      if (response.statusCode == 200) {
        final data = json
            .decode(response.body)['data']; // Ambil objek 'data' dari respons
        user.value = KaryawanModel.fromJson(data);
      }
    } catch (e) {
      // Tangani exception
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
