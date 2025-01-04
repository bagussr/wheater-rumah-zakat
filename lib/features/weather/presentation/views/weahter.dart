// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/converter.dart';
import '../../domain/entity/forecast.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/information_card.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  late Timer _timer;
  String _currentTime = '';
  String _currentDate = '';

  @override
  void initState() {
    super.initState();
    _updateTimeAndDate(); // Initialize the time and date
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTimeAndDate();
    });
  }

  void _updateTimeAndDate() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(now); // e.g., 12:34:56 PM
      _currentDate = DateFormat('EEEE, MMM d, yyyy')
          .format(now); // e.g., Monday, Jan 1, 2025
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Selamat Pagi';
    } else if (hour >= 12 && hour < 15) {
      return 'Selamat Siang';
    } else if (hour >= 15 && hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  List<Forecast> groupedForecast(List<Forecast> data) {
    List<Forecast> list = [];
    for (var tmp in data) {
      var date = tmp.dtTxt.split(' ')[0];
      if (list
          .where((element) => element.dtTxt.split(' ')[0] == date)
          .isEmpty) {
        list.add(tmp);
      }
    }
    return list;
  }

  // get day from dt_txt
  String getDayFromDtTxt(String dtTxt) {
    final dateTime = DateTime.parse(dtTxt);
    final dayOfWeek = DateFormat('EEEE').format(dateTime).substring(0, 3);
    return dayOfWeek;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Rumah Zakat'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherCheck) {
            final currentWeather = state.getForecasts[0];
            final forecasts = groupedForecast(state.getForecasts);
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _greetingCard(state.name, _getGreeting()),
                        SizedBox(height: 24),
                        Align(
                          alignment: Alignment.center,
                          child: InformationCard(
                            currentWeather: currentWeather,
                            currentDate: _currentDate,
                            currentTime: _currentTime,
                            province: state.province,
                            regency: state.regency,
                          ),
                        ),
                        SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 120,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 64,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade300,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(2, 4),
                                          blurRadius: 2,
                                          color: Colors.black26,
                                        )
                                      ]),
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Column(
                                    children: [
                                      Text(
                                        getDayFromDtTxt(forecasts[index].dtTxt),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Image(
                                          image: NetworkImage(
                                              'https://openweathermap.org/img/wn/${forecasts[index].weather[0].icon}@2x.png')),
                                      Text(
                                        kelvinToCelsius(
                                            forecasts[index].main.temp),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: 5),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}

Widget _greetingCard(String name, String greeting) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$greeting,',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    ],
  );
}
