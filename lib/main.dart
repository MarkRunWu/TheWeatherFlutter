import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_weather_flutter/injectable.dart';
import 'package:the_weather_flutter/ui/home_screen.dart';

void main() async {
  await configureDependencies();
  runApp(const ProviderScope(child: TheWeatherApp()));
}

class TheWeatherApp extends StatelessWidget {
  const TheWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The weather flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}
