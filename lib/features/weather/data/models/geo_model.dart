// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../domain/entity/geo.dart';

class GeoModel {
  final String name;
  final num lat;
  final num lon;
  final String country;
  final String state;
  GeoModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  GeoModel copyWith({
    String? name,
    num? lat,
    num? lon,
    String? country,
    String? state,
  }) {
    return GeoModel(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      country: country ?? this.country,
      state: state ?? this.state,
    );
  }

  Geo toEntity() =>
      Geo(country: country, lat: lat, lon: lon, name: name, state: state);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }

  factory GeoModel.fromMap(Map<String, dynamic> map) {
    return GeoModel(
      name: map['name'] as String,
      lat: map['lat'] as num,
      lon: map['lon'] as num,
      country: map['country'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoModel.fromJson(String source) =>
      GeoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GeoModel(name: $name, lat: $lat, lon: $lon, country: $country, state: $state)';
  }

  @override
  bool operator ==(covariant GeoModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.lat == lat &&
        other.lon == lon &&
        other.country == country &&
        other.state == state;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        lat.hashCode ^
        lon.hashCode ^
        country.hashCode ^
        state.hashCode;
  }
}
