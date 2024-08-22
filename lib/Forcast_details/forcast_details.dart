
import 'package:flutter/material.dart';
import 'package:weatherwise_weather_app/Forcast_details/screens/home_page2.dart';
import 'package:weatherwise_weather_app/Forcast_details/theme/app_theme.dart';

class ForcastDetailsScreen extends StatefulWidget {
  const ForcastDetailsScreen({super.key});

  @override
  State<ForcastDetailsScreen> createState() => _forcast_detailsState();
}

class _forcast_detailsState extends State<ForcastDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      title: 'WeatherWise',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      home: const HomePage(),
    );;
  }
}
