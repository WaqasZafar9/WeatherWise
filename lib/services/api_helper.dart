import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import '/constants/constants.dart';
import '/models/hourly_weather.dart';
import '/models/weather.dart';
import '/models/weekly_weather.dart';
import '/services/geolocator.dart';
import '/utils/logging.dart';

@immutable
class ApiHelper {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5'; // Corrected version
  static const weeklyweatherUrl = 'https://historical-forecast-api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&start_date=2024-08-04&end_date=2024-08-18&hourly=temperature_2m&timezone=auto';

  static double lat = 0.0;
  static double lon = 0.0;
  static final dio = Dio();

  static Future<void> fetchLocation() async {
    final location = await getLocation();
    lat = location.latitude;
    lon = location.longitude;
  }

  //* Current Weather
  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  //* Hourly Weather
  static Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructForecastUrl();
    final response = await _fetchData(url);
    return HourlyWeather.fromJson(response);
  }

  //* Weekly weather
  static Future<WeeklyWeather> getWeeklyForecast() async {
    await fetchLocation();
    final url = _constructWeeklyForecastUrl();
    final response = await _fetchData(url);

    // Log the raw response for debugging
    print('Raw API Response: $response');

    // Check if the response is a list and handle accordingly
    if (response is List<dynamic> && response.isNotEmpty) {
      // Parse the first item in the list (assuming that's what you want)
      return WeeklyWeather.fromJson(response[0] as Map<String, dynamic>);
    } else if (response is Map<String, dynamic>) {
      return WeeklyWeather.fromJson(response);
    } else {
      throw Exception('Unexpected response format');
    }
  }


  //* Weather by City Name
  static Future<Weather> getWeatherByCityName({
    required String cityName,
  }) async {
    final url = _constructWeatherByCityUrl(cityName);
    final response = await _fetchData(url);
    return Weather.fromJson(response);
  }

  //! Build urls
  static String _constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${Constants
          .apiKey}';

  static String _constructForecastUrl() =>
      '$baseUrl/forecast?lat=$lat&lon=$lon&units=metric&appid=${Constants
          .apiKey}';

  static String _constructWeatherByCityUrl(String cityName) =>
      '$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}';

  static String _constructWeeklyForecastUrl() {
    return '$weeklyweatherUrl&latitude=$lat&longitude=$lon';
  }


  //* Fetch Data for a url
  static Future<dynamic> _fetchData(String url) async {
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // Check if the response data is a List or a Map
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        } else if (response.data is List<dynamic>) {
          return response.data as List<dynamic>;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        printWarning('Failed to load data: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      printWarning('Error fetching data from $url: $e');
      throw Exception('Error fetching data');
    }
  }
}