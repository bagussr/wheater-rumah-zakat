import 'package:dartz/dartz.dart';
import 'package:wheater_rumah_zakat/features/weather/domain/entity/forecast.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/typedef/typedef.dart';
import '../../domain/entity/area.dart';
import '../../domain/repository/weather_repository.dart';
import '../datasource/weather_datasource.dart';

class WeatherRepositoryImplements implements WeatherRepository {
  WeatherRepositoryImplements({required this.datasource});
  WeatherDatasource datasource;

  @override
  FutureResult<List<Area>> getArea() async {
    try {
      List<Area> list = [];
      final result = await datasource.getProvince();
      for (var tmp in result) {
        list.add(tmp.toEntity());
      }
      return Right(list);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureResult<List<Forecast>> getWeather(String area) async {
    try {
      List<Forecast> list = [];
      final result = await datasource.getWeather(area);
      for (var tmp in result) {
        list.add(tmp.toEntity());
      }
      return Right(list);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
