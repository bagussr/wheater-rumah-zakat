class Forecast {
  const Forecast({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.pop,
    required this.visibility,
  });

  final MainForecast main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final num visibility;
  final num pop;
}

class Wind {
  const Wind({required this.speed, required this.deg});
  final num speed;
  final num deg;

  Map<String, dynamic> toMap() {
    return {
      'speed': speed,
      'deg': deg,
    };
  }

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(speed: map['speed'], deg: map['deg']);
  }
}

class Clouds {
  const Clouds({required this.all});
  final num all;

  Map<String, dynamic> toMap() {
    return {
      'all': all,
    };
  }

  factory Clouds.fromMap(Map<String, dynamic> map) {
    return Clouds(all: map['all']);
  }
}

class Weather {
  const Weather({
    required this.id,
    required this.description,
    required this.main,
    required this.icon,
  });

  final num id;
  final String description;
  final String main;
  final String icon;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'main': main,
      'icon': icon,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
        id: map['id'],
        description: map['description'],
        main: map['main'],
        icon: map['icon']);
  }
}

class MainForecast {
  const MainForecast({
    required this.feelsLike,
    required this.groundLevel,
    required this.humidity,
    required this.pressure,
    required this.seaLevel,
    required this.temp,
    required this.tempKf,
    required this.tempMax,
    required this.tempMin,
  });

  final num temp;
  final num feelsLike;
  final num tempMin;
  final num tempMax;
  final num pressure;
  final num seaLevel;
  final num groundLevel;
  final num humidity;
  final num tempKf;

  Map<String, dynamic> toMap() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': groundLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }

  factory MainForecast.fromMap(Map<String, dynamic> map) {
    return MainForecast(
        temp: map['temp'],
        feelsLike: map['feels_like'],
        tempMin: map['temp_min'],
        tempMax: map['temp_max'],
        pressure: map['pressure'],
        seaLevel: map['sea_level'],
        groundLevel: map['grnd_level'],
        humidity: map['humidity'],
        tempKf: map['temp_kf']);
  }
}
