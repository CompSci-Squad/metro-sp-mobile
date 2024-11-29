import 'apiService.dart';

void main() async {
  // Create an instance of ApiService with your base URL
  final apiService = ApiService(baseUrl: 'https://jsonplaceholder.typicode.com');
  
  try {
    // Make a GET request
    final response = await apiService.get('/telaLogin');
    print('GET Response: $response');
    
    // Make a POST request
    final postResponse = await apiService.post('/posts', {
      'title': 'foo',
      'body': 'bar',
      'userId': 1
    });
    print('POST Response: $postResponse');
  } catch (e) {
    print('Error: $e');
  }
}