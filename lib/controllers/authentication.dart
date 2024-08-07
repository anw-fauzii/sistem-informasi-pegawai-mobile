import 'package:belajar_flutter/pages/dashboard.dart';
import 'package:belajar_flutter/pages/login_page.dart'; // Import halaman login
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:belajar_flutter/constants/constants.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;

  final box = GetStorage();

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        Uri.parse('$url/api/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseData = json.decode(response.body);
        token.value = responseData['token'];
        var user = responseData['user'];
        box.write('token', token.value);
        box.write('user', user);
        Get.offAll(() => const Dashboard());
      } else {
        isLoading.value = false;
        Get.snackbar('error', json.decode(response.body)['message'],
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future logout() async {
    try {
      var response = await http.post(
        Uri.parse('$url/api/logout'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (response.statusCode == 200) {
        box.erase();
        token.value = '';
        Get.offAll(() => const LoginPage()); // Redirect to login page
      } else {
        Get.snackbar('error', 'Logout failed',
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.white);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
