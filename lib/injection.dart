import 'package:get_it/get_it.dart';

import 'features/weather/data/datasource/weather_datasource.dart';
import 'features/weather/data/repository/weather_repository_implements.dart';
import 'features/weather/domain/usecase/get_province.dart';
import 'features/weather/domain/usecase/get_weather.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory<WeatherBloc>(() => WeatherBloc(
      getProvince: locator<GetProvince>(), getWeather: locator<GetWeather>()));

  locator.registerLazySingleton(
      () => GetProvince(repository: locator<WeatherRepositoryImplements>()));
  locator.registerLazySingleton(
      () => GetWeather(repository: locator<WeatherRepositoryImplements>()));

  locator.registerLazySingleton(() => WeatherRepositoryImplements(
      datasource: locator<WeatherDatasourceImplements>()));

  locator.registerLazySingleton(() => WeatherDatasourceImplements());
}
