// ========================================
// REST API LEARNING - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('🚀 REST API LEARNING - SIMPLE EXAMPLES\n');

  // 1. Basic HTTP Methods
  await basicHttpMethods();

  // 2. JSON Parsing
  await jsonParsing();

  // 3. Future and Await
  await futureAwait();

  // 4. Streams
  await streams();

  // 5. Caching
  await caching();

  print('\n✅ All examples completed!');
}

// ========================================
// 1. BASIC HTTP METHODS
// ========================================

Future<void> basicHttpMethods() async {
  print('🌐 BASIC HTTP METHODS');
  print('--------------------');

  // GET Request
  print('\n📖 GET Request:');
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('✅ Title: ${data['title']}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }

  // POST Request
  print('\n➕ POST Request:');
  try {
    final newPost = {'title': 'My Post', 'body': 'Post content', 'userId': 1};

    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(newPost),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('✅ Created Post ID: ${data['id']}');
    }
  } catch (e) {
    print('❌ Error: $e');
  }

  // PUT Request
  print('\n🔄 PUT Request:');
  try {
    final updatedPost = {
      'id': 1,
      'title': 'Updated Title',
      'body': 'Updated content',
      'userId': 1,
    };

    final response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedPost),
    );

    if (response.statusCode == 200) {
      print('✅ Post updated successfully');
    }
  } catch (e) {
    print('❌ Error: $e');
  }

  // DELETE Request
  print('\n🗑️ DELETE Request:');
  try {
    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      print('✅ Post deleted successfully');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

// ========================================
// 2. JSON PARSING
// ========================================

Future<void> jsonParsing() async {
  print('\n📄 JSON PARSING');
  print('----------------');

  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );

    if (response.statusCode == 200) {
      // Parse JSON string to Map
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      print('✅ Post ID: ${jsonData['id']}');
      print('✅ Title: ${jsonData['title']}');
      print('✅ User ID: ${jsonData['userId']}');

      // Create JSON from Dart object
      final user = {'name': 'John Doe', 'email': 'john@example.com', 'age': 25};

      final jsonString = jsonEncode(user);
      print('✅ JSON string: $jsonString');
    }
  } catch (e) {
    print('❌ Error: $e');
  }
}

// ========================================
// 3. FUTURE AND AWAIT
// ========================================

Future<void> futureAwait() async {
  print('\n⏳ FUTURE AND AWAIT');
  print('------------------');

  print('Starting API call...');

  // Without await - returns Future immediately
  final futureResponse = http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
  );
  print('✅ Future created (not completed yet)');

  // With await - wait for Future to complete
  final response = await futureResponse;
  print('✅ Future completed! Status: ${response.statusCode}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('📄 Post title: ${data['title']}');
  }

  // Multiple API calls - Parallel (faster)
  print('\n⚡ Parallel API calls:');
  final futures = <Future<http.Response>>[];
  for (int i = 1; i <= 3; i++) {
    futures.add(
      http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$i')),
    );
  }

  final responses = await Future.wait(futures);
  for (int i = 0; i < responses.length; i++) {
    final data = jsonDecode(responses[i].body);
    print('📄 Post ${i + 1}: ${data['title']}');
  }
}

// ========================================
// 4. STREAMS
// ========================================

Future<void> streams() async {
  print('\n🌊 STREAMS');
  print('----------');

  print('Starting stream...');

  // Listen to stream data
  await for (String data in getBasicStream()) {
    print('📡 Received: $data');
  }

  print('✅ Stream completed!');
}

// Generate a basic stream
Stream<String> getBasicStream() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield 'Data update $i at ${DateTime.now().toString().substring(11, 19)}';
  }
}

// ========================================
// 5. CACHING
// ========================================

// Simple cache
Map<String, dynamic> cache = {};
Map<String, DateTime> cacheTimestamps = {};
Duration cacheExpiry = Duration(minutes: 5);

bool isCacheValid(String key) {
  final timestamp = cacheTimestamps[key];
  if (timestamp == null) return false;
  return DateTime.now().difference(timestamp) < cacheExpiry;
}

dynamic getFromCache(String key) {
  if (isCacheValid(key)) {
    print('💾 Cache HIT for: $key');
    return cache[key];
  }
  print('❌ Cache MISS for: $key');
  return null;
}

void setCache(String key, dynamic value) {
  cache[key] = value;
  cacheTimestamps[key] = DateTime.now();
  print('💾 Cached: $key');
}

Future<void> caching() async {
  print('\n💾 CACHING');
  print('----------');

  final url = 'https://jsonplaceholder.typicode.com/posts/1';

  // First call - will fetch from API
  print('\n📡 First call (API):');
  final data1 = await getCachedData(url);
  print('📄 Title: ${data1['title']}');

  // Second call - will use cache
  print('\n💾 Second call (Cache):');
  final data2 = await getCachedData(url);
  print('📄 Title: ${data2['title']}');

  // Clear cache
  print('\n🧹 Clearing cache...');
  cache.clear();
  cacheTimestamps.clear();

  // Third call - will fetch from API again
  print('\n📡 Third call (API again):');
  final data3 = await getCachedData(url);
  print('📄 Title: ${data3['title']}');
}

Future<Map<String, dynamic>> getCachedData(String url) async {
  // Check cache first
  final cachedData = getFromCache(url);
  if (cachedData != null) {
    return cachedData;
  }

  // If not in cache, fetch from API
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Cache the result
      setCache(url, data);

      return data;
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}
