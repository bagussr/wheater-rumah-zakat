import '../../../../core/typedef/typedef.dart';
import '../../../../core/usecase/use_case.dart';
import '../entity/forecast.dart';
import '../repository/weather_repository.dart';

class GetWeather extends UsecaseWithParams<List<Forecast>, String> {
  GetWeather({required this.repository});
  final WeatherRepository repository;

  @override
  FutureResult<List<Forecast>> call(String params) async {
    return await repository.getWeather(params);
  }
}
