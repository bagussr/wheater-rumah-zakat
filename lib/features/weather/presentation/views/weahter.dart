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
  List<String> listDate = [];

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

  Map<String, List<Forecast>> groupedForecast(List<Forecast> data) {
    final Map<String, List<Forecast>> map = {};
    for (var tmp in data) {
      var date = tmp.dtTxt.split(' ')[0];
      if (listDate.where((element) => element == date).isEmpty) {
        listDate.add(date);
      }
      map.putIfAbsent(date, () => []).add(tmp);
    }
    return map;
  }

  // get day from dt_txt
  String getDayFromDtTxt(String dtTxt) {
    final dateTime = DateTime.parse(dtTxt);
    final dayOfWeek = DateFormat('EEEE').format(dateTime).substring(0, 3);
    return dayOfWeek;
  }

  // get time from dt_txt
  String getTimeFromDtTxt(String dtTxt) {
    final dateTime = DateTime.parse(dtTxt);
    final time = DateFormat('hh:mm a').format(dateTime);
    return time;
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
                          height: 240,
                          child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.all(2),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: double.infinity,
                                  height: 100,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade300,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(2, 4),
                                          blurRadius: 2,
                                          color: Colors.black26,
                                        )
                                      ]),
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        getDayFromDtTxt(listDate[index]),
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index2) {
                                              if (forecasts[listDate[index]]!
                                                  .asMap()
                                                  .containsKey(index2)) {
                                                var temp = forecasts[
                                                    listDate[index]]![index2];
                                                return SizedBox(
                                                  height: 40,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          getTimeFromDtTxt(
                                                              temp.dtTxt),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      12)),
                                                      Image(
                                                        image: NetworkImage(
                                                            'https://openweathermap.org/img/wn/${temp.weather[0].icon}@2x.png'),
                                                        height: 44,
                                                      ),
                                                      Text(
                                                        kelvinToCelsius(
                                                            temp.main.temp),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                              return Container();
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                width: 18,
                                              );
                                            },
                                            itemCount: 5),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 18,
                                );
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
