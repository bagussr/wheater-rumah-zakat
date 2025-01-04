import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constant/uri.dart';
import '../../../../core/errors/failure.dart';
import '../models/area_model.dart';

abstract class WeatherDatasource {
  Future<List<AreaModel>> getProvince();
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
}
