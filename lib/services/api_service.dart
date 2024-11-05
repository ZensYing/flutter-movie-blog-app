// api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiService {
  final String _baseUrl = AppConfig.baseUrl;

  Future<dynamic> getRequest(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl$endpoint?api_key=${AppConfig.apiKey}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
