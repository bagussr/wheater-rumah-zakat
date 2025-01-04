import 'package:flutter_dotenv/flutter_dotenv.dart';

String? apiKey = dotenv.env['API_KEY'] ??
    '411488f3a021468958f89d2344a17a01'; // example using default key <api key of author this repository>

String weatherUri(num lat, num lon) {
  String xApi =
      "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&lang=id";
  return xApi;
}

String geoUri(String cityName) {
  return 'https://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$apiKey';
}
