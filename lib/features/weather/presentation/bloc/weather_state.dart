part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  List<Forecast> get getForecasts => [];

  List<Area> get getAreas => [];

  String? get getErrors => null;

  @override
  List<Object?> get props => [];
}

final class WeatherInitial extends WeatherState {
  const WeatherInitial({required this.areas});

  final List<Area> areas;

  @override
  List<Area> get getAreas => areas;

  @override
  List<Object> get props => [areas];
}

final class WeatherCheck extends WeatherState {
  const WeatherCheck(
      {required this.name,
      required this.regency,
      required this.province,
      required this.forecasts});

  final String name;
  final String regency;
  final String province;
  final List<Forecast> forecasts;

  @override
  List<Forecast> get getForecasts => forecasts;

  @override
  List<Object?> get props => [name, regency];
}

final class WeatherError extends WeatherState {
  const WeatherError({this.errors, required this.areas});
  final String? errors;
  final List<Area> areas;

  @override
  List<Area> get getAreas => areas;

  @override
  String? get getErrors => errors;

  @override
  List<Object?> get props => [errors];
}

final class WeatherLoading extends WeatherState {}
