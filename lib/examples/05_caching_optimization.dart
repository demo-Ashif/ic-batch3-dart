// ========================================
// CACHING AND OPTIMIZATION EXAMPLES
// ========================================

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://jsonplaceholder.typicode.com';

// Simple in-memory cache
class SimpleCache {
  static final Map<String, dynamic> _cache = {};
  static final Map<String, DateTime> _timestamps = {};
  static const Duration _defaultExpiry = Duration(minutes: 5);

  static bool _isValid(String key, Duration expiry) {
    final timestamp = _timestamps[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < expiry;
  }

  static dynamic get(String key, {Duration? expiry}) {
    final cacheExpiry = expiry ?? _defaultExpiry;

    if (_isValid(key, cacheExpiry)) {
      print('💾 Cache HIT for: $key');
      return _cache[key];
    }

    print('❌ Cache MISS for: $key');
    return null;
  }

  static void set(String key, dynamic value, {Duration? expiry}) {
    _cache[key] = value;
    _timestamps[key] = DateTime.now();
    print('💾 Cached: $key');
  }

  static void remove(String key) {
    _cache.remove(key);
    _timestamps.remove(key);
    print('🗑️ Removed from cache: $key');
  }

  static void clear() {
    _cache.clear();
    _timestamps.clear();
    print('🧹 Cache cleared');
  }

  static int get size => _cache.length;
  static List<String> get keys => _cache.keys.toList();
}

// Advanced cache with TTL and size limits
class AdvancedCache {
  static final Map<String, _CacheEntry> _cache = {};
  static const int _maxSize = 100;
  static const Duration _defaultTTL = Duration(minutes: 10);

  static dynamic get(String key) {
    final entry = _cache[key];

    if (entry != null && !entry.isExpired) {
      entry.lastAccessed = DateTime.now();
      print('💾 Cache HIT for: $key (${entry.hitCount} hits)');
      return entry.data;
    }

    if (entry != null && entry.isExpired) {
      _cache.remove(key);
      print('⏰ Cache EXPIRED for: $key');
    } else {
      print('❌ Cache MISS for: $key');
    }

    return null;
  }

  static void set(String key, dynamic value, {Duration? ttl}) {
    // Remove expired entries first
    _removeExpiredEntries();

    // If cache is full, remove least recently used
    if (_cache.length >= _maxSize && !_cache.containsKey(key)) {
      _removeLRU();
    }

    _cache[key] = _CacheEntry(
      data: value,
      ttl: ttl ?? _defaultTTL,
      createdAt: DateTime.now(),
      lastAccessed: DateTime.now(),
    );

    print('💾 Cached: $key (${_cache.length}/${_maxSize} entries)');
  }

  static void _removeExpiredEntries() {
    final expiredKeys =
        _cache.keys.where((key) => _cache[key]!.isExpired).toList();

    for (final key in expiredKeys) {
      _cache.remove(key);
    }

    if (expiredKeys.isNotEmpty) {
      print('🧹 Removed ${expiredKeys.length} expired entries');
    }
  }

  static void _removeLRU() {
    String? lruKey;
    DateTime? oldestAccess = DateTime.now();

    for (final entry in _cache.entries) {
      if (entry.value.lastAccessed.isBefore(oldestAccess!)) {
        oldestAccess = entry.value.lastAccessed;
        lruKey = entry.key;
      }
    }

    if (lruKey != null) {
      _cache.remove(lruKey);
      print('🗑️ Removed LRU entry: $lruKey');
    }
  }

  static void clear() {
    _cache.clear();
    print('🧹 Advanced cache cleared');
  }

  static Map<String, dynamic> getStats() {
    final totalHits = _cache.values.fold<int>(
      0,
      (sum, entry) => sum + entry.hitCount,
    );
    final avgHits = _cache.isEmpty ? 0 : totalHits / _cache.length;

    return {
      'size': _cache.length,
      'maxSize': _maxSize,
      'totalHits': totalHits,
      'averageHits': avgHits,
      'utilization':
          '${((_cache.length / _maxSize) * 100).toStringAsFixed(1)}%',
    };
  }
}

// Cache entry class
class _CacheEntry {
  final dynamic data;
  final Duration ttl;
  final DateTime createdAt;
  DateTime lastAccessed;
  int hitCount = 0;

  _CacheEntry({
    required this.data,
    required this.ttl,
    required this.createdAt,
    required this.lastAccessed,
  });

  bool get isExpired => DateTime.now().difference(createdAt) > ttl;

  void incrementHits() {
    hitCount++;
  }
}

class CachingExamples {
  static Future<void> runAllExamples() async {
    print('💾 CACHING AND OPTIMIZATION EXAMPLES');
    print('====================================\n');

    await simpleCachingExample();
    await advancedCachingExample();
    await cachePerformanceComparison();
    await cacheInvalidationExample();
    await optimizationTechniques();
  }

  // Simple caching example
  static Future<void> simpleCachingExample() async {
    print('💾 SIMPLE CACHING EXAMPLE');
    print('------------------------');

    final url = '$baseUrl/posts/1';

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
  static Future<Map<String, dynamic>> getCachedData(String url) async {
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

  // Advanced caching example
  static Future<void> advancedCachingExample() async {
    print('🚀 ADVANCED CACHING EXAMPLE');
    print('---------------------------');

    final urls = ['$baseUrl/posts/1', '$baseUrl/posts/2', '$baseUrl/posts/3'];

    // Load data into cache
    print('📡 Loading data into cache...');
    for (final url in urls) {
      final data = await getAdvancedCachedData(url);
      print('📄 Cached: ${data['title']}');
    }

    // Access cached data multiple times
    print('\n💾 Accessing cached data...');
    for (int i = 0; i < 3; i++) {
      for (final url in urls) {
        final data = await getAdvancedCachedData(url);
        print('📄 Retrieved: ${data['title']}');
      }
    }

    // Show cache statistics
    final stats = AdvancedCache.getStats();
    print('\n📊 Cache Statistics:');
    print('  Size: ${stats['size']}/${stats['maxSize']}');
    print('  Utilization: ${stats['utilization']}');
    print('  Total Hits: ${stats['totalHits']}');
    print('  Average Hits: ${stats['averageHits'].toStringAsFixed(1)}');
    print('');
  }

  // Get data with advanced caching
  static Future<Map<String, dynamic>> getAdvancedCachedData(String url) async {
    // Check cache first
    final cachedData = AdvancedCache.get(url);
    if (cachedData != null) {
      return cachedData;
    }

    // If not in cache, fetch from API
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Cache the result with short TTL for demo
        AdvancedCache.set(url, data, ttl: Duration(seconds: 30));

        return data;
      } else {
        throw Exception('HTTP ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  // Cache performance comparison
  static Future<void> cachePerformanceComparison() async {
    print('⚡ CACHE PERFORMANCE COMPARISON');
    print('------------------------------');

    final url = '$baseUrl/posts/1';
    final iterations = 5;

    // Without cache
    final noCacheStopwatch = Stopwatch()..start();
    for (int i = 0; i < iterations; i++) {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      print('📡 API call ${i + 1}: ${data['title']}');
    }
    final noCacheTime = noCacheStopwatch.elapsedMilliseconds;

    // With cache
    SimpleCache.clear();
    final cacheStopwatch = Stopwatch()..start();
    for (int i = 0; i < iterations; i++) {
      final data = await getCachedData(url);
      print('💾 Cache call ${i + 1}: ${data['title']}');
    }
    final cacheTime = cacheStopwatch.elapsedMilliseconds;

    // Performance comparison
    final speedup = noCacheTime / cacheTime;
    print('\n📊 Performance Results:');
    print('  Without cache: ${noCacheTime}ms');
    print('  With cache: ${cacheTime}ms');
    print('  Speedup: ${speedup.toStringAsFixed(2)}x faster');
    print('');
  }

  // Cache invalidation example
  static Future<void> cacheInvalidationExample() async {
    print('🔄 CACHE INVALIDATION EXAMPLE');
    print('-----------------------------');

    final url = '$baseUrl/posts/1';

    // Load data into cache
    print('📡 Loading data into cache...');
    final data1 = await getCachedData(url);
    print('📄 Cached: ${data1['title']}');

    // Simulate data update
    print('\n🔄 Simulating data update...');
    SimpleCache.remove(url);

    // Fetch updated data
    print('📡 Fetching updated data...');
    final data2 = await getCachedData(url);
    print('📄 Updated: ${data2['title']}');

    // Show cache status
    print('\n💾 Cache status:');
    print('  Cache size: ${SimpleCache.size}');
    print('  Cached keys: ${SimpleCache.keys}');
    print('');
  }

  // Optimization techniques
  static Future<void> optimizationTechniques() async {
    print('🚀 OPTIMIZATION TECHNIQUES');
    print('-------------------------');

    await parallelCaching();
    await requestBatching();
    await compressionExample();
  }

  // Parallel caching
  static Future<void> parallelCaching() async {
    print('⚡ PARALLEL CACHING');
    print('------------------');

    final urls = [
      '$baseUrl/posts/1',
      '$baseUrl/posts/2',
      '$baseUrl/posts/3',
      '$baseUrl/posts/4',
      '$baseUrl/posts/5',
    ];

    final stopwatch = Stopwatch()..start();

    // Parallel execution
    final futures = urls.map((url) => getCachedData(url)).toList();
    final results = await Future.wait(futures);

    final time = stopwatch.elapsedMilliseconds;

    print('📊 Parallel Results:');
    print('  Fetched ${results.length} items in ${time}ms');
    for (int i = 0; i < results.length; i++) {
      print('  ${i + 1}. ${results[i]['title']}');
    }
    print('');
  }

  // Request batching
  static Future<void> requestBatching() async {
    print('📦 REQUEST BATCHING');
    print('------------------');

    final postIds = [1, 2, 3, 4, 5];

    // Individual requests
    final individualStopwatch = Stopwatch()..start();
    for (final id in postIds) {
      final response = await http.get(Uri.parse('$baseUrl/posts/$id'));
      final data = jsonDecode(response.body);
      print('📄 Individual: ${data['title']}');
    }
    final individualTime = individualStopwatch.elapsedMilliseconds;

    // Batched request (simulated)
    final batchStopwatch = Stopwatch()..start();
    final batchResponse = await http.get(Uri.parse('$baseUrl/posts'));
    final batchData = jsonDecode(batchResponse.body) as List;

    for (int i = 0; i < postIds.length; i++) {
      final data = batchData[i];
      print('📄 Batched: ${data['title']}');
    }
    final batchTime = batchStopwatch.elapsedMilliseconds;

    print('\n📊 Batching Results:');
    print('  Individual: ${individualTime}ms');
    print('  Batched: ${batchTime}ms');
    print(
      '  Improvement: ${((individualTime - batchTime) / individualTime * 100).toStringAsFixed(1)}% faster',
    );
    print('');
  }

  // Compression example
  static Future<void> compressionExample() async {
    print('🗜️ COMPRESSION EXAMPLE');
    print('---------------------');

    final url = '$baseUrl/posts';

    // Without compression
    final noCompressionStopwatch = Stopwatch()..start();
    final response1 = await http.get(Uri.parse(url));
    final noCompressionTime = noCompressionStopwatch.elapsedMilliseconds;
    final noCompressionSize = response1.body.length;

    // With compression (simulated)
    final compressionStopwatch = Stopwatch()..start();
    final response2 = await http.get(
      Uri.parse(url),
      headers: {'Accept-Encoding': 'gzip, deflate'},
    );
    final compressionTime = compressionStopwatch.elapsedMilliseconds;
    final compressionSize = response2.body.length;

    print('📊 Compression Results:');
    print(
      '  Without compression: ${noCompressionSize} bytes, ${noCompressionTime}ms',
    );
    print('  With compression: ${compressionSize} bytes, ${compressionTime}ms');
    print(
      '  Size reduction: ${((noCompressionSize - compressionSize) / noCompressionSize * 100).toStringAsFixed(1)}%',
    );
    print('');
  }
}

// Run this example
void main() async {
  await CachingExamples.runAllExamples();
}
