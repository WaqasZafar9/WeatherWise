import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherwise_weather_app/services/api_helper.dart';

final weeklyWeatherProvider = FutureProvider.autoDispose((ref) async {
  final forecast = await ApiHelper.getWeeklyForecast();
  if (forecast.daily.weatherCode.isEmpty) {
    print("Error: Weather data is empty or null");
  }
  return forecast;
});
