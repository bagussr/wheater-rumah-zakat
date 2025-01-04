// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entity/area.dart';

class AreaModel {
  final String provinsi;
  final List<String> kota;
  AreaModel({
    required this.provinsi,
    required this.kota,
  });

  AreaModel copyWith({
    String? provinsi,
    List<String>? kota,
  }) {
    return AreaModel(
      provinsi: provinsi ?? this.provinsi,
      kota: kota ?? this.kota,
    );
  }

  Area toEntity() => Area(provinsi: provinsi, kota: kota);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'provinsi': provinsi,
      'kota': kota,
    };
  }

  factory AreaModel.fromMap(Map<String, dynamic> map) {
    return AreaModel(
      provinsi: map['provinsi'],
      kota: map['kota'] != null
          ? List<String>.from((map['kota'] as List<dynamic>).map((x) => x))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory AreaModel.fromJson(String source) =>
      AreaModel.fromMap(json.decode(source));

  @override
  String toString() => 'AreaModel(provinsi: $provinsi, kota: $kota)';

  @override
  bool operator ==(covariant AreaModel other) {
    if (identical(this, other)) return true;

    return other.provinsi == provinsi && other.kota == kota;
  }

  @override
  int get hashCode => provinsi.hashCode ^ kota.hashCode;
}
