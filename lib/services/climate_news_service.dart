import 'dart:convert';
import 'package:http/http.dart' as http;

class ClimateNewsService {
  final String apiKey = 'cd2261249emsh1fb1e7f5b1fa0d6p117758jsnf21a74270989';
  final String apiHost = 'weather338.p.rapidapi.com';

  Future<List<dynamic>> fetchClimateNews() async {
    final uri = Uri.parse('https://weather338.p.rapidapi.com/news/list?offset=0&limit=10');

    final response = await http.get(
      uri,
      headers: {
        'x-rapidapi-key': apiKey,
        'x-rapidapi-host': apiHost,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data ?? []; // Return the list of articles
    } else {
      throw Exception('Failed to load climate news');
    }
  }
}
