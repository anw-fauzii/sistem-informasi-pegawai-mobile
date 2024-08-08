class YaumiyahModel {
  final int id;
  final String yaumiyah;
  String selectedValue;

  YaumiyahModel({
    required this.id,
    required this.yaumiyah,
    this.selectedValue = 'Tidak',
  });

  factory YaumiyahModel.fromJson(Map<String, dynamic> json) {
    return YaumiyahModel(
      id: json['id'],
      yaumiyah: json['yaumiyah'],
      selectedValue: json['selectedValue'] ?? 'Tidak',
    );
  }
}
