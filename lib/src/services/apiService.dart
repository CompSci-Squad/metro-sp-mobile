import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Common method to handle HTTP requests
  Future<Map<String, dynamic>> _handleRequest(String url, String method,
      {Map<String, String>? headers, dynamic body}) async {
    Uri uri = Uri.parse('$baseUrl$url');
    http.Response response;

    try {
      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response =
              await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PUT':
          response =
              await http.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'PATCH':
          response =
              await http.patch(uri, headers: headers, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          throw Exception('Unsupported HTTP method');
      }

      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to make $method request: $e');
    }
  }

  // Process the response and handle errors
  Map<String, dynamic> _processResponse(http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed with status code: $statusCode');
    }
  }

  // Method to make GET request
  Future<Map<String, dynamic>> get(String url,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'GET', headers: headers);
  }

  // Method to make POST request
  Future<Map<String, dynamic>> post(String url, dynamic body,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'POST', headers: headers, body: body);
  }

  // Method to make PUT request
  Future<Map<String, dynamic>> put(String url, dynamic body,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'PUT', headers: headers, body: body);
  }

  // Method to make PATCH request
  Future<Map<String, dynamic>> patch(String url, dynamic body,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'PATCH', headers: headers, body: body);
  }

  // Method to make DELETE request
  Future<Map<String, dynamic>> delete(String url,
      {Map<String, String>? headers}) async {
    return _handleRequest(url, 'DELETE', headers: headers);
  }
}

ApiService apiService = ApiService(baseUrl: "http://localhost:3000");
