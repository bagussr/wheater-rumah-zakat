import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/area.dart';
import '../../domain/usecase/get_province.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetProvince getProvince;
  WeatherBloc({required this.getProvince})
      : super(WeatherInitial(areas: const [])) {
    on<WeatherInitalEvent>(_weatherInitialEvent);
  }

  FutureOr<void> _weatherInitialEvent(
      WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    await getProvince().then((value) => value.fold(
          (err) => emit(WeatherError(errors: err.message)),
          (res) => emit(WeatherInitial(areas: res)),
        ));
  }
}
