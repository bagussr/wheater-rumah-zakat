import 'package:flutter_dotenv/flutter_dotenv.dart';

String? apiKey = dotenv.env['API_KEY'] ??
    '411488f3a021468958f89d2344a17a01'; // example using default key <api key of author this repository>

String weatherUri(String lat, String lon) {
  String xApi =
      "api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey";
  return xApi;
}

String provincesUri = "https://wilayah.id/api/provinces.json";

String regenciesUri(String provinceCode) {
  return "https://wilayah.id/api/regencies/$provinceCode.json";
}
