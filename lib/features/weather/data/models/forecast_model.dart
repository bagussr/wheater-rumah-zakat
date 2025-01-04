// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../domain/entity/forecast.dart';

class ForecastModel {
  final MainForecast main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final num visibility;
  final num pop;
  ForecastModel({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
  });

  ForecastModel copyWith({
    MainForecast? main,
    List<Weather>? weather,
    Clouds? clouds,
    Wind? wind,
    num? visibility,
    num? pop,
  }) {
    return ForecastModel(
      main: main ?? this.main,
      weather: weather ?? this.weather,
      clouds: clouds ?? this.clouds,
      wind: wind ?? this.wind,
      visibility: visibility ?? this.visibility,
      pop: pop ?? this.pop,
    );
  }

  Forecast toEntity() => Forecast(
      main: main,
      weather: weather,
      clouds: clouds,
      wind: wind,
      pop: pop,
      visibility: visibility);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'main': main.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'clouds': clouds.toMap(),
      'wind': wind.toMap(),
      'visibility': visibility,
      'pop': pop,
    };
  }

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
      main: MainForecast.fromMap(map['main']),
      weather: List<Weather>.from(
        (map['weather'] as List<dynamic>).map<Weather>(
          (x) => Weather.fromMap(x),
        ),
      ),
      clouds: Clouds.fromMap(map['clouds']),
      wind: Wind.fromMap(map['wind']),
      visibility: map['visibility'],
      pop: map['pop'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastModel.fromJson(String source) =>
      ForecastModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ForecastModel(main: $main, weather: $weather, clouds: $clouds, wind: $wind, visibility: $visibility, pop: $pop)';
  }

  @override
  bool operator ==(covariant ForecastModel other) {
    if (identical(this, other)) return true;

    return other.main == main &&
        listEquals(other.weather, weather) &&
        other.clouds == clouds &&
        other.wind == wind &&
        other.visibility == visibility &&
        other.pop == pop;
  }

  @override
  int get hashCode {
    return main.hashCode ^
        weather.hashCode ^
        clouds.hashCode ^
        wind.hashCode ^
        visibility.hashCode ^
        pop.hashCode;
  }
}
