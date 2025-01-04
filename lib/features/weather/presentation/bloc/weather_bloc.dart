import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/area.dart';
import '../../domain/entity/forecast.dart';
import '../../domain/usecase/get_province.dart';
import '../../domain/usecase/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetProvince getProvince;
  final GetWeather getWeather;
  WeatherBloc({required this.getProvince, required this.getWeather})
      : super(WeatherInitial(areas: const [])) {
    on<WeatherInitalEvent>(_weatherInitialEvent);
    on<WeatherCheckEvent>(_weatherCheckEvent);
  }

  FutureOr<void> _weatherCheckEvent(
      WeatherCheckEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final prevState = state;
    await getWeather(event.regency).then((value) => value.fold(
          (err) => emit(
              WeatherError(errors: err.message, areas: prevState.getAreas)),
          (res) => emit(
            WeatherCheck(
                forecasts: res,
                name: event.name,
                regency: event.regency,
                province: event.province),
          ),
        ));
  }

  FutureOr<void> _weatherInitialEvent(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    await getProvince().then((value) => value.fold(
          (err) => emit(WeatherError(errors: err.message, areas: const [])),
          (res) => emit(WeatherInitial(areas: res)),
        ));
  }
}
