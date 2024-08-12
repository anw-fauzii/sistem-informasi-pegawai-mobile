import 'package:belajar_flutter/constants/constants.dart';

class UserModel {
  final String name;
  final String email;
  final String? foto;

  UserModel({
    required this.name,
    required this.email,
    this.foto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      foto: json['foto'] != null ? '$url/storage/${json['foto']}' : null,
    );
  }
}
