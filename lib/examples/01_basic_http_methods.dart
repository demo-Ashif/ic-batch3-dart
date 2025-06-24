// ========================================
// BASIC HTTP METHODS EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class BasicHttpMethods {
  static Future<void> runAllExamples() async {
    print('🌐 BASIC HTTP METHODS EXAMPLES');
    print('==============================\n');

    await getExample();
    await postExample();
    await putExample();
    await deleteExample();
  }

  // GET Request - Read data
  static Future<void> getExample() async {
    print('📖 GET REQUEST EXAMPLE');
    print('----------------------');

    try {
      print('Fetching post with ID 1...');

      final response = await http.get(
        Uri.parse('$baseUrl/posts/1'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('✅ Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('📄 Title: ${data['title']}');
        print('📝 Body: ${data['body']}');
        print('👤 User ID: ${data['userId']}');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // POST Request - Create data
  static Future<void> postExample() async {
    print('➕ POST REQUEST EXAMPLE');
    print('----------------------');

    try {
      final newPost = {
        'title': 'My First Post from Dart',
        'body': 'This post was created using Dart HTTP package',
        'userId': 1,
      };

      print('Creating new post...');
      print('📄 Title: ${newPost['title']}');

      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(newPost),
      );

      print('✅ Status Code: ${response.statusCode}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('🆔 Created Post ID: ${data['id']}');
        print('📄 Title: ${data['title']}');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // PUT Request - Update entire resource
  static Future<void> putExample() async {
    print('🔄 PUT REQUEST EXAMPLE');
    print('----------------------');

    try {
      final updatedPost = {
        'id': 1,
        'title': 'Updated Title via PUT',
        'body': 'This post was completely updated using PUT',
        'userId': 1,
      };

      print('Updating post with ID 1...');
      print('📄 New Title: ${updatedPost['title']}');

      final response = await http.put(
        Uri.parse('$baseUrl/posts/1'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(updatedPost),
      );

      print('✅ Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('📄 Updated Title: ${data['title']}');
        print('📝 Updated Body: ${data['body']}');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // DELETE Request - Remove resource
  static Future<void> deleteExample() async {
    print('🗑️ DELETE REQUEST EXAMPLE');
    print('-------------------------');

    try {
      print('Deleting post with ID 1...');

      final response = await http.delete(
        Uri.parse('$baseUrl/posts/1'),
        headers: {'Content-Type': 'application/json'},
      );

      print('✅ Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('✅ Post deleted successfully');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }
}

// Run this example
void main() async {
  await BasicHttpMethods.runAllExamples();
}
