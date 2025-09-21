// ========================================
// STREAMS - SIMPLE EXAMPLES
// ========================================

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() async {
  print('🌊 STREAMS EXAMPLES\n');

  // 1. Basic stream
  await basicStreamExample();

  // 2. API polling with stream
  await apiPollingStream();

  // 3. Stream transformation
  await streamTransformation();

  // 4. Stream error handling
  await streamErrorHandling();
}

// Basic stream
// Why? Streams provide continuous data flow
// Best use case: Real-time updates, progress tracking
Future<void> basicStreamExample() async {
  print('🌊 BASIC STREAM');
  print('---------------');

  print('Starting basic stream...');

  // Listen to stream data
  await for (String data in getBasicStream()) {
    print('📡 Received: $data');
  }

  print('✅ Stream completed!');
  print('');
}

// Generate a basic stream
Stream<String> getBasicStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield 'Data update $i at ${DateTime.now().toString().substring(11, 19)}';
  }
}

// API polling with stream
// Why? Get real-time updates from server
// Best use case: Live chat, stock prices, notifications
Future<void> apiPollingStream() async {
  print('📡 API POLLING STREAM');
  print('--------------------');

  print('Starting API polling (will poll 3 times)...');

  int count = 0;
  await for (Map<String, dynamic> data in pollApiData()) {
    count++;
    print('📊 Poll $count: ${data['title'] ?? data['error']}');

    if (count >= 3) break; // Stop after 3 polls for demo
  }

  print('✅ Polling completed!');
  print('');
}

// Generate API polling stream
Stream<Map<String, dynamic>> pollApiData() async* {
  while (true) {
    try {
      // Get a random post ID (1-10)
      final postId = DateTime.now().millisecond % 10 + 1;

      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId'),
      );

      if (response.statusCode == 200) {
        yield jsonDecode(response.body);
      } else {
        yield {'error': 'HTTP ${response.statusCode}'};
      }
    } catch (e) {
      yield {'error': e.toString()};
    }

    // Wait 2 seconds before next poll
    await Future.delayed(Duration(seconds: 2));
  }
}

// Stream transformation
// Why? Modify data as it flows through stream
// Best use case: Data filtering, formatting, validation
Future<void> streamTransformation() async {
  print('🔄 STREAM TRANSFORMATION');
  print('------------------------');

  print('Transforming stream data...');

  // Transform and filter stream data
  await for (String transformed in getBasicStream()
      .map((data) => '🔄 TRANSFORMED: $data')
      .where((data) => data.contains('3') || data.contains('5'))) {
    print(transformed);
  }

  print('✅ Transformation completed!');
  print('');
}

// Stream error handling
// Why? Streams can fail, need to handle errors gracefully
// Best use case: Network streams, file streams
Future<void> streamErrorHandling() async {
  print('🚨 STREAM ERROR HANDLING');
  print('------------------------');

  print('Starting stream with error handling...');

  try {
    await for (String data in getStreamWithErrors()) {
      print('📡 Received: $data');
    }
  } catch (e) {
    print('❌ Stream error caught: $e');
  }

  print('✅ Error handling completed!');
  print('');
}

// Generate stream with errors
Stream<String> getStreamWithErrors() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));

    if (i == 3) {
      throw Exception('Simulated error at iteration $i');
    }

    yield 'Data $i at ${DateTime.now().toString().substring(11, 19)}';
  }
}
