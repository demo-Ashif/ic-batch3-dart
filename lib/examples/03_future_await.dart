// ========================================
// FUTURE AND AWAIT - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  print('⏳ FUTURE AND AWAIT EXAMPLES\n');

  // 1. Basic async/await
  await basicAsyncExample();

  // 2. Multiple API calls
  await multipleApiCalls();

  // 3. Error handling
  await errorHandlingExample();

  // 4. Parallel vs Sequential
  await parallelVsSequential();
}

// Basic async/await
// Why? API calls take time, we need to wait for them
// Best use case: Any network request, file operations
Future<void> basicAsyncExample() async {
  print('🔄 BASIC ASYNC/AWAIT');
  print('-------------------');

  print('Starting API call...');

  // Without await - this returns a Future immediately
  final futureResponse = http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
  );
  print('✅ Future created (not completed yet)');

  // With await - wait for the Future to complete
  final response = await futureResponse;
  print('✅ Future completed! Status: ${response.statusCode}');

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print('📄 Post title: ${data['title']}');
  }
  print('');
}

// Multiple API calls
// Why? Need to fetch multiple pieces of data
// Best use case: Loading user profile + posts, dashboard data
Future<void> multipleApiCalls() async {
  print('📊 MULTIPLE API CALLS');
  print('--------------------');

  // Sequential calls (one after another)
  print('🔄 Sequential calls:');
  for (int i = 1; i <= 3; i++) {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$i'),
    );
    final data = jsonDecode(response.body);
    print('📄 Post $i: ${data['title']}');
  }

  print('\n⚡ Parallel calls:');
  // Parallel calls (all at once)
  final futures = <Future<http.Response>>[];
  for (int i = 1; i <= 3; i++) {
    futures.add(
      http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$i')),
    );
  }

  // Wait for all to complete
  final responses = await Future.wait(futures);
  for (int i = 0; i < responses.length; i++) {
    final data = jsonDecode(responses[i].body);
    print('📄 Post ${i + 1}: ${data['title']}');
  }
  print('');
}

// Error handling
// Why? Network can fail, servers can be down
// Best use case: Always handle errors in production apps
Future<void> errorHandlingExample() async {
  print('🚨 ERROR HANDLING');
  print('-----------------');

  // Successful call
  try {
    print('✅ Making successful API call...');
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    print('✅ Success: ${response.statusCode}');
  } catch (e) {
    print('❌ Error: $e');
  }

  // Failed call
  try {
    print('\n❌ Making failed API call...');
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/invalid-endpoint'),
    );
    print('✅ Success: ${response.statusCode}');
  } catch (e) {
    print('❌ Caught error: $e');
  }
  print('');
}

// Parallel vs Sequential performance
// Why? Parallel is faster for multiple independent requests
// Best use case: Loading dashboard with multiple data sources
Future<void> parallelVsSequential() async {
  print('⚡ PARALLEL VS SEQUENTIAL');
  print('------------------------');

  final urls = [
    'https://jsonplaceholder.typicode.com/posts/1',
    'https://jsonplaceholder.typicode.com/posts/2',
    'https://jsonplaceholder.typicode.com/posts/3',
  ];

  // Sequential execution
  print('🔄 Sequential execution:');
  final sequentialStopwatch = Stopwatch()..start();

  for (String url in urls) {
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body);
    print('📄 ${data['title']}');
  }

  final sequentialTime = sequentialStopwatch.elapsedMilliseconds;
  print('⏱️ Sequential time: ${sequentialTime}ms');

  // Parallel execution
  print('\n⚡ Parallel execution:');
  final parallelStopwatch = Stopwatch()..start();

  final futures = urls.map((url) => http.get(Uri.parse(url))).toList();
  final responses = await Future.wait(futures);

  for (var response in responses) {
    final data = jsonDecode(response.body);
    print('📄 ${data['title']}');
  }

  final parallelTime = parallelStopwatch.elapsedMilliseconds;
  print('⏱️ Parallel time: ${parallelTime}ms');

  // Performance comparison
  final speedup = sequentialTime / parallelTime;
  print('\n📊 Performance:');
  print('Sequential: ${sequentialTime}ms');
  print('Parallel: ${parallelTime}ms');
  print('Speedup: ${speedup.toStringAsFixed(2)}x faster');
  print('');
}
