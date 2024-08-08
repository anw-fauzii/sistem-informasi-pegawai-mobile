class YaumiyahPegawaiModel {
  final int id;
  final String nipy;
  final int yaumiyahId;
  final String? tanggal;
  final String keterangan;

  YaumiyahPegawaiModel({
    required this.id,
    required this.nipy,
    required this.yaumiyahId,
    this.tanggal,
    required this.keterangan,
  });

  factory YaumiyahPegawaiModel.fromJson(Map<String, dynamic> json) {
    return YaumiyahPegawaiModel(
      id: json['id'],
      nipy: json['nipy'],
      yaumiyahId: json['yaumiyah_id'],
      tanggal: json['tanggal'],
      keterangan: json['keterangan'],
    );
  }
}
