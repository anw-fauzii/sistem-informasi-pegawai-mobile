// lib/models/bulan_model.dart

class BulanModel {
  final String bulan;

  BulanModel({
    required this.bulan,
  });

  factory BulanModel.fromJson(Map<String, dynamic> json) {
    return BulanModel(
      bulan: json['bulan'],
    );
  }
}
