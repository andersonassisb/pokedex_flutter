import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  const ApiService(this.baseUrl);

  Future<dynamic> getData(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Request data failed and has returned with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('GET request error: $e');
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Send data failed and has returned with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('POST request error: $e');
    }
  }
}