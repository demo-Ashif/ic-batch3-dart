// ========================================
// FUTURE AND AWAIT EXAMPLES
// ========================================

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class FutureAwaitExamples {
  static Future<void> runAllExamples() async {
    print('⏳ FUTURE AND AWAIT EXAMPLES');
    print('============================\n');

    await basicFutureExample();
    await multipleApiCalls();
    await errorHandlingExample();
    await timeoutExample();
    await parallelVsSequential();
  }

  // Basic Future and Await example
  static Future<void> basicFutureExample() async {
    print('🔄 BASIC FUTURE AND AWAIT');
    print('-------------------------');

    print('Starting API call...');

    // This returns a Future<Response>
    final futureResponse = http.get(Uri.parse('$baseUrl/posts/1'));
    print('✅ Future created, but not awaited yet');

    // Await waits for the Future to complete
    final response = await futureResponse;
    print('✅ Future completed! Status: ${response.statusCode}');

    // Process the result
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('📄 Post title: ${data['title']}');
    }
    print('');
  }

  // Multiple API calls comparison
  static Future<void> multipleApiCalls() async {
    print('📊 MULTIPLE API CALLS COMPARISON');
    print('--------------------------------');

    final stopwatch = Stopwatch()..start();

    // Sequential calls (slower)
    print('🔄 Making sequential API calls...');
    for (int i = 1; i <= 3; i++) {
      final response = await http.get(Uri.parse('$baseUrl/posts/$i'));
      print(
        '📄 Post $i: ${response.statusCode} - ${jsonDecode(response.body)['title']}',
      );
    }

    print('⏱️ Sequential time: ${stopwatch.elapsedMilliseconds}ms');

    // Parallel calls (faster)
    stopwatch.reset();
    print('\n⚡ Making parallel API calls...');

    final futures = <Future<http.Response>>[];
    for (int i = 1; i <= 3; i++) {
      futures.add(http.get(Uri.parse('$baseUrl/posts/$i')));
    }

    final responses = await Future.wait(futures);
    for (int i = 0; i < responses.length; i++) {
      print(
        '📄 Post ${i + 1}: ${responses[i].statusCode} - ${jsonDecode(responses[i].body)['title']}',
      );
    }

    print('⏱️ Parallel time: ${stopwatch.elapsedMilliseconds}ms');
    print('');
  }

  // Error handling with try-catch
  static Future<void> errorHandlingExample() async {
    print('🚨 ERROR HANDLING EXAMPLE');
    print('-------------------------');

    // Successful call
    try {
      print('✅ Making successful API call...');
      final response = await http.get(Uri.parse('$baseUrl/posts/1'));
      print('✅ Success: ${response.statusCode}');
    } catch (e) {
      print('❌ Error: $e');
    }

    // Failed call (invalid URL)
    try {
      print('\n❌ Making failed API call...');
      final response = await http.get(Uri.parse('$baseUrl/invalid-endpoint'));
      print('✅ Success: ${response.statusCode}');
    } catch (e) {
      print('❌ Caught error: $e');
    }

    // Network error simulation
    try {
      print('\n🌐 Making network call to invalid domain...');
      final response = await http.get(
        Uri.parse('https://invalid-domain-12345.com'),
      );
      print('✅ Success: ${response.statusCode}');
    } catch (e) {
      print('❌ Network error: $e');
    }
    print('');
  }

  // Timeout example
  static Future<void> timeoutExample() async {
    print('⏰ TIMEOUT EXAMPLE');
    print('-----------------');

    try {
      print('⏳ Making API call with 5 second timeout...');

      final response = await http
          .get(Uri.parse('$baseUrl/posts/1'))
          .timeout(Duration(seconds: 5));

      print('✅ Response received: ${response.statusCode}');
    } on TimeoutException {
      print('⏰ Timeout: Request took too long');
    } catch (e) {
      print('❌ Other error: $e');
    }

    // Simulate slow response
    try {
      print('\n⏳ Making slow API call with 2 second timeout...');

      final response = await Future.delayed(Duration(seconds: 3))
          .then((_) => http.get(Uri.parse('$baseUrl/posts/1')))
          .timeout(Duration(seconds: 2));

      print('✅ Response received: ${response.statusCode}');
    } on TimeoutException {
      print('⏰ Timeout: Request took too long');
    } catch (e) {
      print('❌ Other error: $e');
    }
    print('');
  }

  // Parallel vs Sequential performance
  static Future<void> parallelVsSequential() async {
    print('⚡ PARALLEL VS SEQUENTIAL PERFORMANCE');
    print('------------------------------------');

    final urls = [
      '$baseUrl/posts/1',
      '$baseUrl/posts/2',
      '$baseUrl/posts/3',
      '$baseUrl/posts/4',
      '$baseUrl/posts/5',
    ];

    // Sequential execution
    final sequentialStopwatch = Stopwatch()..start();
    print('🔄 Sequential execution:');

    for (String url in urls) {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      print('  📄 ${data['title']}');
    }

    final sequentialTime = sequentialStopwatch.elapsedMilliseconds;
    print('⏱️ Sequential time: ${sequentialTime}ms');

    // Parallel execution
    final parallelStopwatch = Stopwatch()..start();
    print('\n⚡ Parallel execution:');

    final futures = urls.map((url) => http.get(Uri.parse(url))).toList();
    final responses = await Future.wait(futures);

    for (var response in responses) {
      final data = jsonDecode(response.body);
      print('  📄 ${data['title']}');
    }

    final parallelTime = parallelStopwatch.elapsedMilliseconds;
    print('⏱️ Parallel time: ${parallelTime}ms');

    // Performance comparison
    final speedup = sequentialTime / parallelTime;
    print('\n📊 Performance comparison:');
    print('  Sequential: ${sequentialTime}ms');
    print('  Parallel: ${parallelTime}ms');
    print('  Speedup: ${speedup.toStringAsFixed(2)}x faster');
    print('');
  }
}

// Additional utility functions
class FutureUtils {
  // Simulate a slow operation
  static Future<String> simulateSlowOperation(
    String operation,
    int seconds,
  ) async {
    print('⏳ Starting $operation...');
    await Future.delayed(Duration(seconds: seconds));
    print('✅ Completed $operation');
    return 'Result of $operation';
  }

  // Chain multiple async operations
  static Future<void> chainOperations() async {
    print('\n🔗 CHAINING ASYNC OPERATIONS');
    print('----------------------------');

    final result1 = await simulateSlowOperation('Step 1', 1);
    final result2 = await simulateSlowOperation('Step 2', 1);
    final result3 = await simulateSlowOperation('Step 3', 1);

    print('📋 Final results:');
    print('  $result1');
    print('  $result2');
    print('  $result3');
    print('');
  }

  // Use Future.value for immediate values
  static Future<void> futureValueExample() async {
    print('💎 FUTURE.VALUE EXAMPLE');
    print('----------------------');

    // Create a Future that completes immediately
    final immediateFuture = Future.value('Hello from Future!');
    print('✅ Future created with immediate value');

    // Await it
    final result = await immediateFuture;
    print('📄 Result: $result');
    print('');
  }
}

// Run this example
void main() async {
  await FutureAwaitExamples.runAllExamples();
  await FutureUtils.chainOperations();
  await FutureUtils.futureValueExample();
}
