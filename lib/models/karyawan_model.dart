import 'package:belajar_flutter/models/user_model.dart';

class KaryawanModel {
  final UserModel userModel;
  final int? nik;
  final String? golongan;
  final String? tempat;
  final String? alamat;
  final int? rt;
  final int? rw;
  final String? kelurahan;
  final String? kecamatan;
  final String? tglLahir;
  final String? mulaiTugas;
  final String? jk;
  final String? jabatan;
  final String? unit;
  final String? pendidikan;
  final String? perguruan;
  final String? prodi;
  final String? thnLulus;
  final String? wa;
  final String? email;
  final String? nuptk;
  final String? agama;

  KaryawanModel({
    required this.userModel,
    required this.nik,
    required this.golongan,
    required this.tempat,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.kelurahan,
    required this.kecamatan,
    required this.tglLahir,
    required this.mulaiTugas,
    required this.jk,
    required this.jabatan,
    required this.unit,
    required this.pendidikan,
    required this.perguruan,
    required this.prodi,
    required this.thnLulus,
    required this.wa,
    required this.email,
    required this.nuptk,
    required this.agama,
  });

  factory KaryawanModel.fromJson(Map<String, dynamic> json) {
    return KaryawanModel(
      userModel: UserModel.fromJson(json['user']),
      nik: json['nik'] != null ? json['nik'] as int : null,
      golongan: json['golongan'] != null ? json['golongan'] as String : null,
      tempat: json['tempat'] != null ? json['tempat'] as String : null,
      alamat: json['alamat'] != null ? json['alamat'] as String : null,
      rt: json['rt'] != null ? json['rt'] as int : null,
      rw: json['rw'] != null ? json['rw'] as int : null,
      kelurahan: json['kelurahan'] != null ? json['kelurahan'] as String : null,
      kecamatan: json['kecamatan'] != null ? json['kecamatan'] as String : null,
      tglLahir: json['tgl_lahir'] != null ? json['tgl_lahir'] as String : null,
      mulaiTugas:
          json['mulai_tugas'] != null ? json['mulai_tugas'] as String : null,
      jk: json['jk'] != null ? json['jk'] as String : null,
      jabatan: json['jabatan'] != null ? json['jabatan'] as String : null,
      unit: json['unit'] != null ? json['unit'] as String : null,
      pendidikan:
          json['pendidikan'] != null ? json['pendidikan'] as String : null,
      perguruan: json['perguruan'] != null ? json['perguruan'] as String : null,
      prodi: json['prodi'] != null ? json['prodi'] as String : null,
      thnLulus: json['thn_lulus'] != null ? json['thn_lulus'] as String : null,
      wa: json['wa'] != null ? json['wa'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      nuptk: json['nuptk'] != null ? json['nuptk'] as String : null,
      agama: json['agama'] != null ? json['agama'] as String : null,
    );
  }
}
