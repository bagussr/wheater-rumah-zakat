import 'package:flutter/material.dart';

import '../../../../core/utils/converter.dart';
import '../../domain/entity/forecast.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    super.key,
    required this.currentWeather,
    required this.currentDate,
    required this.currentTime,
    required this.province,
    required this.regency,
  });
  final Forecast currentWeather;
  final String currentDate;
  final String currentTime;
  final String province;
  final String regency;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          currentDate,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          currentTime,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 16),
        Text(
          '$province - $regency',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    kelvinToCelsius(currentWeather.main.temp),
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'L.${kelvinToCelsius(currentWeather.main.tempMin)} - H.${kelvinToCelsius(currentWeather.main.tempMax)}',
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    currentWeather.weather[0].description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Image(
                      image: NetworkImage(
                          'https://openweathermap.org/img/wn/${currentWeather.weather[0].icon}@2x.png')),
                ],
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Icons.water_drop, size: 32),
                  SizedBox(height: 8),
                  Text('${currentWeather.main.humidity}%'),
                  Text('Humidity',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.cloud_sharp, size: 32),
                  SizedBox(height: 8),
                  Text('${currentWeather.clouds.all}%'),
                  Text('Cloudiness',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.av_timer_rounded, size: 32),
                  SizedBox(height: 8),
                  Text('${currentWeather.main.pressure} hPa'),
                  Text('Pressure',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.speed_rounded, size: 32),
                  SizedBox(height: 8),
                  Text('${currentWeather.wind.speed} m/s'),
                  Text('Wind Speed',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
