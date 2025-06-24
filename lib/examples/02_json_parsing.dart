// ========================================
// JSON PARSING EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://jsonplaceholder.typicode.com';

// Model class for User
class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'website': website,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email)';
  }
}

// Model class for Post
class Post {
  final int id;
  final int userId;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId, 'title': title, 'body': body};
  }

  @override
  String toString() {
    return 'Post(id: $id, title: $title)';
  }
}

class JsonParsingExamples {
  static Future<void> runAllExamples() async {
    print('📄 JSON PARSING EXAMPLES');
    print('========================\n');

    await parseSingleUser();
    await parseUserList();
    await parseSinglePost();
    await parsePostList();
    await createJsonFromObject();
    await handleComplexJson();
  }

  // Parse single user JSON
  static Future<void> parseSingleUser() async {
    print('👤 SINGLE USER PARSING');
    print('----------------------');

    try {
      final response = await http.get(Uri.parse('$baseUrl/users/1'));

      if (response.statusCode == 200) {
        // Raw JSON string
        print('📄 Raw JSON:');
        print(response.body);
        print('');

        // Parse JSON string to Map
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print('🔍 Parsed Map:');
        print('ID: ${jsonData['id']}');
        print('Name: ${jsonData['name']}');
        print('Email: ${jsonData['email']}');
        print('');

        // Create User object from JSON
        final user = User.fromJson(jsonData);
        print('👤 User Object: $user');
        print('');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // Parse list of users
  static Future<void> parseUserList() async {
    print('👥 USER LIST PARSING');
    print('-------------------');

    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        // Parse JSON array
        final List<dynamic> jsonArray = jsonDecode(response.body);
        print('📊 Found ${jsonArray.length} users');
        print('');

        // Convert each JSON object to User
        final List<User> users =
            jsonArray.map((json) => User.fromJson(json)).toList();

        // Print first 3 users
        print('👤 First 3 users:');
        for (int i = 0; i < 3 && i < users.length; i++) {
          final user = users[i];
          print('${i + 1}. ${user.name} (${user.email})');
        }
        print('');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // Parse single post
  static Future<void> parseSinglePost() async {
    print('📝 SINGLE POST PARSING');
    print('---------------------');

    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/1'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final post = Post.fromJson(jsonData);

        print('📄 Post: $post');
        print('📝 Body: ${post.body}');
        print('');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // Parse list of posts
  static Future<void> parsePostList() async {
    print('📚 POST LIST PARSING');
    print('-------------------');

    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonArray = jsonDecode(response.body);
        final List<Post> posts =
            jsonArray.map((json) => Post.fromJson(json)).toList();

        print('📊 Found ${posts.length} posts');
        print('');

        // Print first 3 posts
        print('📝 First 3 posts:');
        for (int i = 0; i < 3 && i < posts.length; i++) {
          final post = posts[i];
          print('${i + 1}. ${post.title}');
        }
        print('');
      } else {
        print('❌ Error: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception: $e');
    }
    print('');
  }

  // Create JSON from object
  static Future<void> createJsonFromObject() async {
    print('🔄 OBJECT TO JSON');
    print('----------------');

    // Create a User object
    final user = User(
      id: 999,
      name: 'John Doe',
      email: 'john@example.com',
      phone: '123-456-7890',
      website: 'johndoe.com',
    );

    print('👤 Original User: $user');

    // Convert to JSON
    final userJson = user.toJson();
    print('📄 JSON Map: $userJson');

    // Convert to JSON string
    final jsonString = jsonEncode(userJson);
    print('📄 JSON String: $jsonString');

    // Parse back to object
    final parsedUser = User.fromJson(jsonDecode(jsonString));
    print('👤 Parsed User: $parsedUser');
    print('');
  }

  // Handle complex JSON structure
  static Future<void> handleComplexJson() async {
    print('🔧 COMPLEX JSON HANDLING');
    print('------------------------');

    // Complex JSON with nested objects and arrays
    final complexJson = {
      'user': {
        'id': 1,
        'name': 'Alice',
        'email': 'alice@example.com',
        'address': {
          'street': '123 Main St',
          'city': 'New York',
          'zipCode': '10001',
        },
        'hobbies': ['reading', 'swimming', 'coding'],
        'isActive': true,
        'score': 95.5,
      },
      'posts': [
        {'id': 1, 'title': 'First Post'},
        {'id': 2, 'title': 'Second Post'},
      ],
      'metadata': {'createdAt': '2024-01-01', 'version': '1.0.0'},
    };

    print('📄 Complex JSON Structure:');
    print(jsonEncode(complexJson));
    print('');

    // Access nested data with null safety
    print('🔍 Accessing nested data:');
    final user = complexJson['user'] as Map<String, dynamic>?;
    final address = user?['address'] as Map<String, dynamic>?;
    final hobbies = user?['hobbies'] as List<dynamic>?;
    final posts = complexJson['posts'] as List<dynamic>?;
    final metadata = complexJson['metadata'] as Map<String, dynamic>?;

    print('User name: ${user?['name']}');
    print('User city: ${address?['city']}');
    print('First hobby: ${hobbies?[0]}');
    print('Number of posts: ${posts?.length}');
    print('Version: ${metadata?['version']}');
    print('');
  }
}

// Run this example
void main() async {
  await JsonParsingExamples.runAllExamples();
}
