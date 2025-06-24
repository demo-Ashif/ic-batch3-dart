// ========================================
// STREAMS EXAMPLES
// ========================================

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class StreamExamples {
  static Future<void> runAllExamples() async {
    print('🌊 STREAMS EXAMPLES');
    print('==================\n');

    await basicStreamExample();
    await apiPollingStream();
    await streamTransformation();
    await streamErrorHandling();
    await streamCancellation();
  }

  // Basic stream example
  static Future<void> basicStreamExample() async {
    print('🌊 BASIC STREAM EXAMPLE');
    print('----------------------');

    print('Starting basic stream...');

    await for (String data in getBasicStream()) {
      print('📡 Received: $data');
    }

    print('✅ Stream completed!');
    print('');
  }

  // Generate a basic stream
  static Stream<String> getBasicStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield 'Data update $i at ${DateTime.now().toString().substring(11, 19)}';
    }
  }

  // API polling stream
  static Future<void> apiPollingStream() async {
    print('📡 API POLLING STREAM');
    print('-------------------');

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
  static Stream<Map<String, dynamic>> pollApiData() async* {
    while (true) {
      try {
        // Get a random post ID (1-10)
        final postId = DateTime.now().millisecond % 10 + 1;

        final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));

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
  static Future<void> streamTransformation() async {
    print('🔄 STREAM TRANSFORMATION');
    print('------------------------');

    print('Transforming stream data...');

    await for (String transformed in getBasicStream()
        .map((data) => '🔄 TRANSFORMED: $data')
        .where((data) => data.contains('3') || data.contains('5'))) {
      print(transformed);
    }

    print('✅ Transformation completed!');
    print('');
  }

  // Stream error handling
  static Future<void> streamErrorHandling() async {
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
  static Stream<String> getStreamWithErrors() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 1));

      if (i == 3) {
        throw Exception('Simulated error at iteration $i');
      }

      yield 'Data $i at ${DateTime.now().toString().substring(11, 19)}';
    }
  }

  // Stream cancellation
  static Future<void> streamCancellation() async {
    print('⏹️ STREAM CANCELLATION');
    print('---------------------');

    print('Starting cancellable stream...');

    final subscription = getInfiniteStream().listen(
      (data) {
        print('📡 Received: $data');
      },
      onError: (error) {
        print('❌ Error: $error');
      },
      onDone: () {
        print('✅ Stream completed');
      },
    );

    // Let it run for 3 seconds, then cancel
    await Future.delayed(Duration(seconds: 3));
    subscription.cancel();
    print('⏹️ Stream cancelled!');
    print('');
  }

  // Generate infinite stream
  static Stream<String> getInfiniteStream() async* {
    int count = 0;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      count++;
      yield 'Infinite data $count at ${DateTime.now().toString().substring(11, 19)}';
    }
  }
}

// Advanced stream examples
class AdvancedStreamExamples {
  // Stream controller example
  static Future<void> streamControllerExample() async {
    print('🎛️ STREAM CONTROLLER EXAMPLE');
    print('----------------------------');

    // Create a stream controller
    final controller = StreamController<String>();

    // Listen to the stream
    final subscription = controller.stream.listen(
      (data) => print('📡 Received: $data'),
      onDone: () => print('✅ Stream done'),
      onError: (error) => print('❌ Error: $error'),
    );

    // Add data to the stream
    controller.add('First message');
    await Future.delayed(Duration(seconds: 1));
    controller.add('Second message');
    await Future.delayed(Duration(seconds: 1));
    controller.add('Third message');

    // Close the stream
    await Future.delayed(Duration(seconds: 1));
    controller.close();

    // Wait for subscription to complete
    await subscription.asFuture();
    print('');
  }

  // Broadcast stream example
  static Future<void> broadcastStreamExample() async {
    print('📢 BROADCAST STREAM EXAMPLE');
    print('--------------------------');

    // Create a broadcast stream controller
    final controller = StreamController<String>.broadcast();

    // Multiple listeners
    final subscription1 = controller.stream.listen(
      (data) => print('👤 Listener 1: $data'),
    );

    final subscription2 = controller.stream.listen(
      (data) => print('👤 Listener 2: $data'),
    );

    // Add data (both listeners will receive it)
    controller.add('Hello to all listeners!');
    await Future.delayed(Duration(seconds: 1));
    controller.add('Another message for everyone!');

    // Cancel first listener
    subscription1.cancel();
    await Future.delayed(Duration(seconds: 1));
    controller.add('Only listener 2 will receive this');

    // Close stream
    controller.close();
    subscription2.cancel();
    print('');
  }

  // Real-time data simulation
  static Future<void> realTimeDataSimulation() async {
    print('📊 REAL-TIME DATA SIMULATION');
    print('----------------------------');

    print('Simulating real-time stock prices...');

    await for (Map<String, dynamic> stockData in generateStockData()) {
      final symbol = stockData['symbol'];
      final price = stockData['price'];
      final change = stockData['change'];
      final emoji = change >= 0 ? '📈' : '📉';

      print(
        '$emoji $symbol: \$${price.toStringAsFixed(2)} (${change >= 0 ? '+' : ''}${change.toStringAsFixed(2)}%)',
      );
    }

    print('✅ Real-time simulation completed!');
    print('');
  }

  // Generate stock data stream
  static Stream<Map<String, dynamic>> generateStockData() async* {
    final stocks = ['AAPL', 'GOOGL', 'MSFT', 'TSLA'];
    final basePrices = {
      'AAPL': 150.0,
      'GOOGL': 2800.0,
      'MSFT': 300.0,
      'TSLA': 800.0,
    };

    for (int i = 0; i < 10; i++) {
      for (String symbol in stocks) {
        final basePrice = basePrices[symbol]!;
        final randomChange =
            (DateTime.now().millisecond % 20 - 10) / 100; // -10% to +10%
        final newPrice = basePrice * (1 + randomChange);
        final changePercent = randomChange * 100;

        yield {
          'symbol': symbol,
          'price': newPrice,
          'change': changePercent,
          'timestamp': DateTime.now(),
        };
      }

      await Future.delayed(Duration(seconds: 1));
    }
  }
}

// Run this example
void main() async {
  await StreamExamples.runAllExamples();
  await AdvancedStreamExamples.streamControllerExample();
  await AdvancedStreamExamples.broadcastStreamExample();
  await AdvancedStreamExamples.realTimeDataSimulation();
}
