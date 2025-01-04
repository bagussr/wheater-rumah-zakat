import '../../../../core/typedef/typedef.dart';
import '../../../../core/usecase/use_case.dart';
import '../entity/area.dart';
import '../repository/weather_repository.dart';

class GetProvince extends Usecase<List<Area>> {
  GetProvince({required this.repository});
  WeatherRepository repository;

  @override
  FutureResult<List<Area>> call() async {
    return await repository.getArea();
  }
}
