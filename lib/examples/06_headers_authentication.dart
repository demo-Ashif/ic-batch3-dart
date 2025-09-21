// ========================================
// HEADERS AND AUTHENTICATION - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('🔐 HEADERS AND AUTHENTICATION EXAMPLES\n');

  // 1. Basic headers
  await basicHeadersExample();

  // 2. API key authentication
  await apiKeyAuthentication();

  // 3. Bearer token authentication
  await bearerTokenAuthentication();

  // 4. Custom headers
  await customHeadersExample();
}

// Basic headers
// Why? Servers need to know what type of data you're sending/receiving
// Best use case: All API calls, content type specification
Future<void> basicHeadersExample() async {
  print('📋 BASIC HEADERS');
  print('----------------');

  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'User-Agent': 'MyApp/1.0',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Success! Title: ${data['title']}');
      print('📋 Response headers: ${response.headers}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  print('');
}

// API key authentication
// Why? Many APIs require API keys for access control
// Best use case: Third-party APIs, rate limiting, usage tracking
Future<void> apiKeyAuthentication() async {
  print('🔑 API KEY AUTHENTICATION');
  print('-------------------------');

  try {
    // Simulate API key authentication
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': 'your-api-key-here',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ API key accepted! Title: ${data['title']}');
    } else {
      print('❌ API key rejected: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  print('');
}

// Bearer token authentication
// Why? Most modern APIs use JWT tokens for authentication
// Best use case: User authentication, secure API access
Future<void> bearerTokenAuthentication() async {
  print('🎫 BEARER TOKEN AUTHENTICATION');
  print('------------------------------');

  try {
    // Simulate bearer token authentication
    final token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'; // JWT token

    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Token accepted! Title: ${data['title']}');
    } else {
      print('❌ Token rejected: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  print('');
}

// Custom headers
// Why? Some APIs require specific custom headers
// Best use case: Specialized APIs, custom authentication methods
Future<void> customHeadersExample() async {
  print('🎨 CUSTOM HEADERS');
  print('-----------------');

  try {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Custom-Header': 'MyCustomValue',
        'X-Client-Version': '1.0.0',
        'X-Platform': 'Flutter',
        'X-User-ID': '12345',
      },
      body: jsonEncode({
        'title': 'Post with custom headers',
        'body': 'This post was sent with custom headers',
        'userId': 1,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('✅ Post created with custom headers! ID: ${data['id']}');
      print('📋 Request headers sent successfully');
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  print('');
}
