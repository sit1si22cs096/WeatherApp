import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import 'dart:convert';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const String _apiKey = 'e1a572348595514e796b2c1a985c7ddf';

  Future<WeatherModel?> getWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to connect to weather service');
    }
  }
}
