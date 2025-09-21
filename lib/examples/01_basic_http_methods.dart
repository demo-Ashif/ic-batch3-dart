// ========================================
// BASIC HTTP METHODS - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('🌐 BASIC HTTP METHODS EXAMPLES\n');

  // 1. GET Request - Read data from server
  await getExample();

  // 2. POST Request - Send data to server
  await postExample();

  // 3. PUT Request - Update entire resource
  await putExample();

  // 4. PATCH Request - Update partial resource
  await patchExample();

  // 5. DELETE Request - Remove resource
  await deleteExample();
}

// GET Request - Why? To fetch/read data from server
// Best use case: Loading user profile, getting posts, fetching settings
Future<void> getExample() async {
  print('📖 GET REQUEST EXAMPLE');
  print('----------------------');

  try {
    // Simple GET request to fetch a post
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Success! Post title: ${data['title']}');
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Exception: $e');
  }
  print('');
}

// POST Request - Why? To create new data on server
// Best use case: User registration, creating posts, submitting forms
Future<void> postExample() async {
  print('➕ POST REQUEST EXAMPLE');
  print('----------------------');

  try {
    // Data to send to server
    final newPost = {
      'title': 'My First Post',
      'body': 'This is my first post using Dart!',
      'userId': 1,
    };

    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newPost),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('✅ Post created! ID: ${data['id']}');
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Exception: $e');
  }
  print('');
}

// PUT Request - Why? To completely replace/update a resource
// Best use case: Updating entire user profile, replacing document
Future<void> putExample() async {
  print('🔄 PUT REQUEST EXAMPLE');
  print('----------------------');

  try {
    // Complete updated data
    final updatedPost = {
      'id': 1,
      'title': 'Updated Title',
      'body': 'This post has been completely updated',
      'userId': 1,
    };

    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedPost),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Post updated! Title: ${data['title']}');
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Exception: $e');
  }
  print('');
}

// PATCH Request - Why? To update only specific fields
// Best use case: Updating only email, changing password, partial updates
Future<void> patchExample() async {
  print('🔧 PATCH REQUEST EXAMPLE');
  print('------------------------');

  try {
    // Only the fields we want to update
    final partialUpdate = {'title': 'Only title updated'};

    final response = await http.patch(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(partialUpdate),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Post patched! Title: ${data['title']}');
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Exception: $e');
  }
  print('');
}

// DELETE Request - Why? To remove data from server
// Best use case: Deleting posts, removing users, clearing data
Future<void> deleteExample() async {
  print('🗑️ DELETE REQUEST EXAMPLE');
  print('-------------------------');

  try {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      print('✅ Post deleted successfully!');
    } else {
      print('❌ Error: ${response.statusCode}');
    }
  } catch (e) {
    print('❌ Exception: $e');
  }
  print('');
}
