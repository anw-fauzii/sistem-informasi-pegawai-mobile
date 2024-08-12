// lib/models/presensi_model.dart

class PresensiModel {
  final String tanggal;
  final String keterangan;
  final int terlambat;
  final int cepat;

  PresensiModel({
    required this.tanggal,
    required this.keterangan,
    required this.terlambat,
    required this.cepat,
  });

  factory PresensiModel.fromJson(Map<String, dynamic> json) {
    return PresensiModel(
      tanggal: json['tanggal'],
      keterangan: json['keterangan'],
      terlambat: json['terlambat'],
      cepat: json['cepat'],
    );
  }
}
