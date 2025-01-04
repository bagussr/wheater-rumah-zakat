part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherInitalEvent extends WeatherEvent {
  const WeatherInitalEvent();
}

class WeatherCheckEvent extends WeatherEvent {
  const WeatherCheckEvent(
      {required this.name, required this.province, required this.regency});

  final String name;
  final String regency;
  final String province;
}
