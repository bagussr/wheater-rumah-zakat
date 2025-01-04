import '../../../../core/typedef/typedef.dart';
import '../entity/area.dart';

abstract class WeatherRepository {
  FutureResult<List<Area>> getArea();
}
