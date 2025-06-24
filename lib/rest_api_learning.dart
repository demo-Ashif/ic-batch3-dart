// ========================================
// REST API LEARNING MODULE FOR BEGINNERS
// ========================================

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

// Global constants
const String baseUrl = 'https://jsonplaceholder.typicode.com';

// ========================================
// 1. REST PROTOCOL EXPLANATION
// ========================================

/*
REST (Representational State Transfer) is an architectural style for designing networked applications.

Key Principles:
- Stateless: Each request contains all information needed
- Client-Server: Separation of concerns
- Cacheable: Responses can be cached
- Uniform Interface: Consistent way to interact with resources
- Layered System: Can be composed of multiple layers

REST uses HTTP as the underlying protocol and treats everything as a resource.
Resources are identified by URLs (Uniform Resource Locators).

Example URLs:
- GET /users          - Get all users
- GET /users/123      - Get user with ID 123
- POST /users         - Create a new user
- PUT /users/123      - Update user 123
- DELETE /users/123   - Delete user 123
*/

// ========================================
// 2. HTTP METHODS EXPLANATION
// ========================================

/*
HTTP Methods (also called HTTP Verbs):

1. GET - Retrieve data (Read)
   - Safe and idempotent
   - Used to fetch information
   - Parameters sent in URL query string
   - Example: GET /api/users?page=1&limit=10

2. POST - Create new data
   - Not idempotent (creates new resource each time)
   - Used to submit data to be processed
   - Data sent in request body
   - Example: POST /api/users (with user data in body)

3. PUT - Update entire resource
   - Idempotent (same result regardless of how many times called)
   - Replaces entire resource
   - Example: PUT /api/users/123 (replaces entire user)

4. PATCH - Partial update
   - Idempotent
   - Updates only specific fields
   - Example: PATCH /api/users/123 (update only email)

5. DELETE - Remove resource
   - Idempotent
   - Removes the specified resource
   - Example: DELETE /api/users/123
*/

// ========================================
// 3. HEADERS AND AUTHENTICATION
// ========================================

/*
HTTP Headers:
Headers provide metadata about the request/response.

Common Headers:
- Content-Type: application/json
- Authorization: Bearer <token>
- Accept: application/json
- User-Agent: Client information
- Cache-Control: Caching instructions

Authentication Types:
1. API Key: Simple key in header or query parameter
2. Bearer Token: JWT or OAuth token
3. Basic Auth: Username:password encoded in base64
4. OAuth: More complex authentication flow
*/

// ========================================
// 4. API CALLING WITH HTTP PACKAGE
// ========================================

class ApiService {
  // GET Request Example
  static Future<void> getExample() async {
    print('\n=== GET REQUEST EXAMPLE ===');

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/1'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed Data: ${data['title']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // POST Request Example
  static Future<void> postExample() async {
    print('\n=== POST REQUEST EXAMPLE ===');

    try {
      final newPost = {
        'title': 'My First Post',
        'body': 'This is the content of my post',
        'userId': 1,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(newPost),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        print('Created Post ID: ${data['id']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // PUT Request Example
  static Future<void> putExample() async {
    print('\n=== PUT REQUEST EXAMPLE ===');

    try {
      final updatedPost = {
        'id': 1,
        'title': 'Updated Title',
        'body': 'Updated content',
        'userId': 1,
      };

      final response = await http.put(
        Uri.parse('$baseUrl/posts/1'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(updatedPost),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  // DELETE Request Example
  static Future<void> deleteExample() async {
    print('\n=== DELETE REQUEST EXAMPLE ===');

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/posts/1'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }
}

// ========================================
// 5. JSON DATA PARSING
// ========================================

class User {
  final int id;
  final String name;
  final String email;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  // Factory constructor to create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'phone': phone};
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, phone: $phone)';
  }
}

class JsonParsingExample {
  static Future<void> parseUserData() async {
    print('\n=== JSON PARSING EXAMPLE ===');

    try {
      final response = await http.get(Uri.parse('$baseUrl/users/1'));

      if (response.statusCode == 200) {
        // Parse JSON string to Map
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        print('Raw JSON: $jsonData');

        // Create User object from JSON
        final user = User.fromJson(jsonData);
        print('Parsed User: $user');

        // Convert back to JSON
        final userJson = user.toJson();
        print('Back to JSON: $userJson');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<void> parseUserList() async {
    print('\n=== JSON ARRAY PARSING EXAMPLE ===');

    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        // Parse JSON array
        final List<dynamic> jsonArray = jsonDecode(response.body);
        print('Found ${jsonArray.length} users');

        // Convert each JSON object to User
        final List<User> users =
            jsonArray.map((json) => User.fromJson(json)).toList();

        // Print first 3 users
        for (int i = 0; i < 3 && i < users.length; i++) {
          print('User ${i + 1}: ${users[i].name} (${users[i].email})');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

// ========================================
// 6. FUTURE AND AWAIT EXPLANATION
// ========================================

/*
Future and Await in Dart:

Future: Represents a value or error that will be available at some time in the future.
- Used for asynchronous operations (like API calls)
- Can be in one of three states: uncompleted, completed with data, completed with error

Await: Keyword used to wait for a Future to complete
- Can only be used inside async functions
- Makes asynchronous code look synchronous
- Automatically handles Future completion

Example Flow:
1. Function calls API (returns Future)
2. Await waits for Future to complete
3. Function continues with the result
*/

class FutureAwaitExample {
  static Future<void> demonstrateFutureAwait() async {
    print('\n=== FUTURE AND AWAIT EXAMPLE ===');

    print('Starting API call...');

    // This returns a Future<Response>
    final futureResponse = http.get(Uri.parse('$baseUrl/posts/1'));
    print('Future created, but not awaited yet');

    // Await waits for the Future to complete
    final response = await futureResponse;
    print('Future completed! Status: ${response.statusCode}');

    // Process the result
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Post title: ${data['title']}');
    }
  }

  static Future<void> multipleApiCalls() async {
    print('\n=== MULTIPLE API CALLS EXAMPLE ===');

    final stopwatch = Stopwatch()..start();

    // Sequential calls (slower)
    print('Making sequential API calls...');
    for (int i = 1; i <= 3; i++) {
      final response = await http.get(Uri.parse('$baseUrl/posts/$i'));
      print('Post $i: ${response.statusCode}');
    }

    print('Sequential time: ${stopwatch.elapsedMilliseconds}ms');

    // Parallel calls (faster)
    stopwatch.reset();
    print('\nMaking parallel API calls...');

    final futures = <Future<http.Response>>[];
    for (int i = 1; i <= 3; i++) {
      futures.add(http.get(Uri.parse('$baseUrl/posts/$i')));
    }

    final responses = await Future.wait(futures);
    for (int i = 0; i < responses.length; i++) {
      print('Post ${i + 1}: ${responses[i].statusCode}');
    }

    print('Parallel time: ${stopwatch.elapsedMilliseconds}ms');
  }
}

// ========================================
// 7. STREAMS FOR LIVE DATA
// ========================================

class StreamExample {
  // Simulate real-time data updates
  static Stream<String> getLiveData() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield 'Data update $i at ${DateTime.now()}';
    }
  }

  static Future<void> demonstrateStream() async {
    print('\n=== STREAM EXAMPLE ===');
    print('Starting live data stream...');

    await for (String data in getLiveData()) {
      print('Received: $data');
    }

    print('Stream completed!');
  }

  // Real-world example: Periodic API polling
  static Stream<Map<String, dynamic>> pollApiData() async* {
    while (true) {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/posts/${DateTime.now().millisecond % 10 + 1}'),
        );

        if (response.statusCode == 200) {
          yield jsonDecode(response.body);
        }
      } catch (e) {
        yield {'error': e.toString()};
      }

      // Wait 2 seconds before next poll
      await Future.delayed(Duration(seconds: 2));
    }
  }

  static Future<void> demonstrateApiPolling() async {
    print('\n=== API POLLING STREAM EXAMPLE ===');
    print('Polling API every 2 seconds (press Ctrl+C to stop)...');

    int count = 0;
    await for (Map<String, dynamic> data in pollApiData()) {
      count++;
      print('Poll $count: ${data['title'] ?? data['error']}');

      if (count >= 3) break; // Stop after 3 polls for demo
    }
  }
}

// ========================================
// 8. API RESPONSE CACHING AND OPTIMIZATION
// ========================================

class CacheManager {
  static final Map<String, dynamic> _cache = {};
  static final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _cacheExpiry = Duration(minutes: 5);

  static bool _isCacheValid(String key) {
    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return false;

    return DateTime.now().difference(timestamp) < _cacheExpiry;
  }

  static dynamic get(String key) {
    if (_isCacheValid(key)) {
      print('Cache HIT for: $key');
      return _cache[key];
    }
    print('Cache MISS for: $key');
    return null;
  }

  static void set(String key, dynamic value) {
    _cache[key] = value;
    _cacheTimestamps[key] = DateTime.now();
    print('Cached: $key');
  }

  static void clear() {
    _cache.clear();
    _cacheTimestamps.clear();
    print('Cache cleared');
  }
}

class OptimizedApiService {
  static Future<Map<String, dynamic>> getCachedData(String url) async {
    final cacheKey = url;

    // Check cache first
    final cachedData = CacheManager.get(cacheKey);
    if (cachedData != null) {
      return cachedData;
    }

    // If not in cache, fetch from API
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Cache the result
        CacheManager.set(cacheKey, data);

        return data;
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<void> demonstrateCaching() async {
    print('\n=== CACHING EXAMPLE ===');

    final url = '$baseUrl/posts/1';

    // First call - will fetch from API
    print('\nFirst call:');
    final data1 = await getCachedData(url);
    print('Title: ${data1['title']}');

    // Second call - will use cache
    print('\nSecond call:');
    final data2 = await getCachedData(url);
    print('Title: ${data2['title']}');

    // Clear cache
    print('\nClearing cache...');
    CacheManager.clear();

    // Third call - will fetch from API again
    print('\nThird call (after cache clear):');
    final data3 = await getCachedData(url);
    print('Title: ${data3['title']}');
  }
}

// ========================================
// MAIN FUNCTION TO RUN ALL EXAMPLES
// ========================================

Future<void> runAllExamples() async {
  print('🚀 REST API LEARNING MODULE FOR BEGINNERS');
  print('==========================================\n');

  // Basic HTTP methods
  await ApiService.getExample();
  await ApiService.postExample();
  await ApiService.putExample();
  await ApiService.deleteExample();

  // JSON parsing
  await JsonParsingExample.parseUserData();
  await JsonParsingExample.parseUserList();

  // Future and await
  await FutureAwaitExample.demonstrateFutureAwait();
  await FutureAwaitExample.multipleApiCalls();

  // Streams
  await StreamExample.demonstrateStream();
  await StreamExample.demonstrateApiPolling();

  // Caching
  await OptimizedApiService.demonstrateCaching();

  print('\n✅ All examples completed!');
  print('\n📚 Key Takeaways:');
  print('1. REST uses HTTP methods to interact with resources');
  print(
    '2. GET for reading, POST for creating, PUT/PATCH for updating, DELETE for removing',
  );
  print('3. Headers provide metadata and authentication');
  print('4. Use http package for API calls in Dart');
  print('5. JSON parsing converts between strings and Dart objects');
  print('6. Future/await handles asynchronous operations');
  print('7. Streams provide real-time data updates');
  print('8. Caching improves performance and reduces API calls');
}
