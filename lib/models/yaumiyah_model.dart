class YaumiyahModel {
  final int id;
  final String yaumiyah;
  final String selectedValue;

  YaumiyahModel({
    required this.id,
    required this.yaumiyah,
    required this.selectedValue,
  });

  factory YaumiyahModel.fromJson(Map<String, dynamic> json) {
    return YaumiyahModel(
      id: json['id'],
      yaumiyah: json['yaumiyah'],
      selectedValue: json['selectedValue'] ?? 'Tidak',
    );
  }
}
