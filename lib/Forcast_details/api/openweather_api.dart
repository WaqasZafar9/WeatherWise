import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeatherAPI {
  final String apiKey = '388d7cc04a77e5d18ae2945a7c565b6e';

  String apiUrl(double lat, double lon) {
    return 'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  }

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url = apiUrl(lat, lon);

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Successfully received response
        return jsonDecode(response.body);
      } else {
        // Handle server errors
        throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}
