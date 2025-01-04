import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constant/uri.dart';
import '../../../../core/errors/failure.dart';
import '../models/area_model.dart';
import '../models/forecast_model.dart';
import '../models/geo_model.dart';

abstract class WeatherDatasource {
  Future<List<AreaModel>> getProvince();
  Future<List<ForecastModel>> getWeather(String areaId);
  Future<GeoModel> getGeoData(String cityName);
}

class WeatherDatasourceImplements implements WeatherDatasource {
  @override
  Future<List<AreaModel>> getProvince() async {
    try {
      List<AreaModel> list = [];
      final response = await rootBundle.loadString('assets/regions.json');
      final data = await jsonDecode(response);

      for (var tmp in data) {
        list.add(AreaModel.fromMap(tmp));
      }
      return list;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<ForecastModel>> getWeather(String areaId) async {
    try {
      List<ForecastModel> list = [];
      final geo = await getGeoData(areaId);
      final response =
          await http.get(Uri.parse(weatherUri(geo.lat, geo.lon)), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      final data = await jsonDecode(response.body);
      for (var tmp in data['list']) {
        list.add(ForecastModel.fromMap(tmp));
      }
      return list;
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<GeoModel> getGeoData(String cityName) async {
    final response = await http.get(Uri.parse(geoUri(cityName)), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=UTF-8',
    });
    if (response.statusCode == 200) {
      final data = await jsonDecode(response.body);
      if (data.length > 0) {
        return GeoModel.fromMap(data[0]);
      }
    }
    throw 'Kota / Kabupaten tidak tersedia';
  }
}
