import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'features/weather/presentation/views/form.dart';
import 'theme/theme.dart';
import 'injection.dart' as di;

void main() async {
  await dotenv.load(fileName: '.env');
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<WeatherBloc>()..add(WeatherInitalEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: customAppBarTheme(),
        ),
        home: const FormWeatherView(),
      ),
    );
  }
}
