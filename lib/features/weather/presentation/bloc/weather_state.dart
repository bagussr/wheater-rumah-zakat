part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

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
  const WeatherCheck({required this.name, required this.regency});

  final String name;
  final String regency;
}

final class WeatherError extends WeatherState {
  const WeatherError({this.errors});
  final String? errors;

  @override
  String? get getErrors => errors;

  @override
  List<Object?> get props => [errors];
}

final class WeatherLoading extends WeatherState {}
