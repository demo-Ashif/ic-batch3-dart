// ========================================
// JSON PARSING - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('📄 JSON PARSING EXAMPLES\n');

  // 1. Parse simple JSON object
  await parseSimpleJson();

  // 2. Parse JSON array
  await parseJsonArray();

  // 3. Create JSON from Dart object
  await createJsonFromObject();

  // 4. Parse nested JSON
  await parseNestedJson();
}

// Parse simple JSON object
// Why? Most APIs return JSON objects
// Best use case: User profile, single post, settings
Future<void> parseSimpleJson() async {
  print('📄 SIMPLE JSON OBJECT PARSING');
  print('-----------------------------');

  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      // Step 1: Convert JSON string to Map
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      // Step 2: Access data using keys
      print('✅ Post ID: ${jsonData['id']}');
      print('✅ Title: ${jsonData['title']}');
      print('✅ User ID: ${jsonData['userId']}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  print('');
}

// Parse JSON array
// Why? APIs often return lists of data
// Best use case: List of posts, users, comments
Future<void> parseJsonArray() async {
  print('📚 JSON ARRAY PARSING');
  print('--------------------');

  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      // Step 1: Convert JSON string to List
      final List<dynamic> jsonArray = jsonDecode(response.body);

      print('✅ Found ${jsonArray.length} posts');

      // Step 2: Loop through array
      for (int i = 0; i < 3; i++) {
        final post = jsonArray[i];
        print('📄 Post ${i + 1}: ${post['title']}');
      }
    }
  } catch (e) {
    print('❌ Error: $e');
  }
  print('');
}

// Create JSON from Dart object
// Why? Need to send data to server
// Best use case: Creating posts, user registration, form submission
Future<void> createJsonFromObject() async {
  print('🔄 CREATE JSON FROM OBJECT');
  print('-------------------------');

  // Step 1: Create Dart object (Map)
  final user = {
    'name': 'John Doe',
    'email': 'john@example.com',
    'age': 25,
    'isActive': true,
  };

  print('👤 Dart object: $user');

  // Step 2: Convert to JSON string
  final jsonString = jsonEncode(user);
  print('📄 JSON string: $jsonString');

  // Step 3: Parse back to Dart object
  final parsedUser = jsonDecode(jsonString);
  print('🔄 Parsed back: $parsedUser');
  print('');
}

// Parse nested JSON
// Why? Real-world APIs have complex structures
// Best use case: User with address, post with comments
Future<void> parseNestedJson() async {
  print('🏗️ NESTED JSON PARSING');
  print('----------------------');

  // Example nested JSON
  final nestedJson = {
    'user': {
      'id': 1,
      'name': 'Alice',
      'address': {
        'street': '123 Main St',
        'city': 'New York',
        'zipCode': '10001',
      },
      'hobbies': ['reading', 'swimming', 'coding'],
    },
    'posts': [
      {'id': 1, 'title': 'First Post'},
      {'id': 2, 'title': 'Second Post'},
    ],
  };

  print('📄 Complex JSON structure created');

  // Access nested data safely
  final user = nestedJson['user'] as Map<String, dynamic>?;
  final address = user?['address'] as Map<String, dynamic>?;
  final hobbies = user?['hobbies'] as List<dynamic>?;
  final posts = nestedJson['posts'] as List<dynamic>?;

  print('👤 User name: ${user?['name']}');
  print('🏠 City: ${address?['city']}');
  print('🎯 First hobby: ${hobbies?[0]}');
  print('📚 Number of posts: ${posts?.length}');
  print('');
}
