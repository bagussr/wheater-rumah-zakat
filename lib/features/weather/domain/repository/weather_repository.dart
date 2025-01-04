import '../../../../core/typedef/typedef.dart';
import '../entity/area.dart';
import '../entity/forecast.dart';

abstract class WeatherRepository {
  FutureResult<List<Area>> getArea();
  FutureResult<List<Forecast>> getWeather(String area);
}
