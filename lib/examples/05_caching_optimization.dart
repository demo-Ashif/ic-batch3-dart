// ========================================
// CACHING AND OPTIMIZATION - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('💾 CACHING AND OPTIMIZATION EXAMPLES\n');

  // 1. Simple caching
  await simpleCachingExample();

  // 2. Cache performance comparison
  await cachePerformanceComparison();

  // 3. Request batching
  await requestBatching();

  // 4. Basic optimization techniques
  await optimizationTechniques();
}

// Simple in-memory cache
class SimpleCache {
  static final Map<String, dynamic> _cache = {};
  static final Map<String, DateTime> _timestamps = {};
  static const Duration _defaultExpiry = Duration(minutes: 5);

  static bool _isValid(String key) {
    final timestamp = _timestamps[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < _defaultExpiry;
  }

  static dynamic get(String key) {
    if (_isValid(key)) {
      print('💾 Cache HIT for: $key');
      return _cache[key];
    }

    print('❌ Cache MISS for: $key');
    return null;
  }

  static void set(String key, dynamic value) {
    _cache[key] = value;
    _timestamps[key] = DateTime.now();
    print('💾 Cached: $key');
  }

  static void clear() {
    _cache.clear();
    _timestamps.clear();
    print('🧹 Cache cleared');
  }
}

// Simple caching example
// Why? Avoid repeated API calls, improve performance
// Best use case: User profiles, settings, static data
Future<void> simpleCachingExample() async {
  print('💾 SIMPLE CACHING');
  print('-----------------');

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
  SimpleCache.clear();

  // Third call - will fetch from API again
  print('\n📡 Third call (API again):');
  final data3 = await getCachedData(url);
  print('📄 Title: ${data3['title']}');
  print('');
}

// Get data with simple caching
Future<Map<String, dynamic>> getCachedData(String url) async {
  // Check cache first
  final cachedData = SimpleCache.get(url);
  if (cachedData != null) {
    return cachedData;
  }

  // If not in cache, fetch from API
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Cache the result
      SimpleCache.set(url, data);

      return data;
    } else {
      throw Exception('HTTP ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch data: $e');
  }
}

// Cache performance comparison
// Why? Show the performance benefit of caching
// Best use case: Measuring app performance improvements
Future<void> cachePerformanceComparison() async {
  print('⚡ CACHE PERFORMANCE COMPARISON');
  print('------------------------------');

  final url = 'https://jsonplaceholder.typicode.com/posts/1';
  final iterations = 3;

  // Without cache
  print('📡 Without cache:');
  final noCacheStopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    print('  📄 Call ${i + 1}: ${data['title']}');
  }
  final noCacheTime = noCacheStopwatch.elapsedMilliseconds;

  // With cache
  SimpleCache.clear();
  print('\n💾 With cache:');
  final cacheStopwatch = Stopwatch()..start();
  for (int i = 0; i < iterations; i++) {
    final data = await getCachedData(url);
    print('  📄 Call ${i + 1}: ${data['title']}');
  }
  final cacheTime = cacheStopwatch.elapsedMilliseconds;

  // Performance comparison
  final speedup = noCacheTime / cacheTime;
  print('\n📊 Performance Results:');
  print('Without cache: ${noCacheTime}ms');
  print('With cache: ${cacheTime}ms');
  print('Speedup: ${speedup.toStringAsFixed(2)}x faster');
  print('');
}

// Request batching
// Why? Reduce number of API calls, improve efficiency
// Best use case: Loading multiple related items
Future<void> requestBatching() async {
  print('📦 REQUEST BATCHING');
  print('------------------');

  final postIds = [1, 2, 3];

  // Individual requests (slower)
  print('📡 Individual requests:');
  final individualStopwatch = Stopwatch()..start();
  for (final id in postIds) {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
    );
    final data = jsonDecode(response.body);
    print('  📄 Post $id: ${data['title']}');
  }
  final individualTime = individualStopwatch.elapsedMilliseconds;

  // Batched request (faster)
  print('\n📦 Batched request:');
  final batchStopwatch = Stopwatch()..start();
  final batchResponse = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );
  final batchData = jsonDecode(batchResponse.body) as List;

  for (int i = 0; i < postIds.length; i++) {
    final data = batchData[i];
    print('  📄 Post ${i + 1}: ${data['title']}');
  }
  final batchTime = batchStopwatch.elapsedMilliseconds;

  print('\n📊 Batching Results:');
  print('Individual: ${individualTime}ms');
  print('Batched: ${batchTime}ms');
  print(
    'Improvement: ${((individualTime - batchTime) / individualTime * 100).toStringAsFixed(1)}% faster',
  );
  print('');
}

// Basic optimization techniques
// Why? Improve app performance and user experience
// Best use case: Production apps, large datasets
Future<void> optimizationTechniques() async {
  print('🚀 OPTIMIZATION TECHNIQUES');
  print('-------------------------');

  await parallelRequests();
  await compressionExample();
}

// Parallel requests
// Why? Load multiple independent data sources simultaneously
// Best use case: Dashboard with multiple widgets
Future<void> parallelRequests() async {
  print('⚡ PARALLEL REQUESTS');
  print('------------------');

  final urls = [
    'https://jsonplaceholder.typicode.com/posts/1',
    'https://jsonplaceholder.typicode.com/posts/2',
    'https://jsonplaceholder.typicode.com/posts/3',
  ];

  final stopwatch = Stopwatch()..start();

  // Parallel execution
  final futures = urls.map((url) => http.get(Uri.parse(url))).toList();
  final responses = await Future.wait(futures);

  final time = stopwatch.elapsedMilliseconds;

  print('📊 Parallel Results:');
  print('Fetched ${responses.length} items in ${time}ms');
  for (int i = 0; i < responses.length; i++) {
    final data = jsonDecode(responses[i].body);
    print('${i + 1}. ${data['title']}');
  }
  print('');
}

// Compression example
// Why? Reduce data transfer, improve loading speed
// Best use case: Large API responses, mobile apps
Future<void> compressionExample() async {
  print('🗜️ COMPRESSION EXAMPLE');
  print('---------------------');

  final url = 'https://jsonplaceholder.typicode.com/posts';

  // Without compression
  final noCompressionStopwatch = Stopwatch()..start();
  final response1 = await http.get(Uri.parse(url));
  final noCompressionTime = noCompressionStopwatch.elapsedMilliseconds;
  final noCompressionSize = response1.body.length;

  // With compression headers
  final compressionStopwatch = Stopwatch()..start();
  final response2 = await http.get(
    Uri.parse(url),
    headers: {'Accept-Encoding': 'gzip, deflate'},
  );
  final compressionTime = compressionStopwatch.elapsedMilliseconds;
  final compressionSize = response2.body.length;

  print('📊 Compression Results:');
  print(
    'Without compression: ${noCompressionSize} bytes, ${noCompressionTime}ms',
  );
  print('With compression: ${compressionSize} bytes, ${compressionTime}ms');
  print(
    'Size reduction: ${((noCompressionSize - compressionSize) / noCompressionSize * 100).toStringAsFixed(1)}%',
  );
  print('');
}
