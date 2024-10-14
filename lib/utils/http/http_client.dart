import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  /// Base URL for API requests
  static const String _baseUrl = 'https://api_pj_base_url';

  /// Function to handle GET requests
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final Uri uri = Uri.parse('$_baseUrl/$endpoint');
      final res = await http
          .get(uri, headers: await _buildHeaders()) // Adds headers if necessary
          .timeout(const Duration(seconds: 10));

      return _handleResponse(res);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  /// Function to handle POST requests
  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final Uri uri = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _buildHeaders();

    try {
      final res = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (res.statusCode < 200 || res.statusCode >= 300) {
        throw Exception('Failed to post data: ${res.reasonPhrase}');
      }

      return _handleResponse(res);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Function to handle PUT requests
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final Uri uri = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _buildHeaders();

    try {
      final res = await http.put(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      return _handleResponse(res);
    } catch (e) {
      throw Exception('Failed to perform PUT request: $e');
    }
  }

  /// Function to handle DELETE requests
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final Uri uri = Uri.parse('$_baseUrl/$endpoint');
    final headers = await _buildHeaders();

    try {
      final res = await http.delete(
        uri,
        headers: headers,
      );

      return _handleResponse(res);
    } catch (e) {
      throw Exception('Failed to delete: $e');
    }
  }

  /// Function to handle the response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw Exception('Failed to decode JSON: ${e.toString()}');
      }
    } else {
      throw Exception('Error: ${response.statusCode}, Body: ${response.body}');
    }
  }

  /// Function to build headers (for tokens, content type, etc.)
  static Future<Map<String, String>> _buildHeaders() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // Add token if needed
      // 'Authorization': 'Bearer $token',
    };
  }
}