import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'features/weather/presentation/views/form.dart';
import 'features/weather/presentation/views/weahter.dart';
import 'theme/theme.dart';
import 'injection.dart' as di;

void main() async {
  await dotenv.load(fileName: '.env');
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _internetConnected = true;

// create funtionn to check internet connection

  Future<bool> _checkInternetConnection() async {
    try {
      await InternetAddress.lookup('google.com');
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkInternetConnection().then((value) {
      setState(() {
        _internetConnected = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_internetConnected == false) {
      return MaterialApp(
        title: 'Weather Rumah Zakat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: customAppBarTheme(),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Weather Rumah Zakat'),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Text('No internet connection'),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => di.locator<WeatherBloc>()..add(WeatherInitalEvent()),
      child: MaterialApp(
        title: 'Weather Rumah Zakat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Color(0xffE9ECF1),
          useMaterial3: true,
          appBarTheme: customAppBarTheme(),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const FormWeatherView(),
          '/weather': (context) => const WeatherView()
        },
      ),
    );
  }
}
