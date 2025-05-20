import 'dart:io';
import 'dart:async';

/// Custom Exception for insufficient funds
class InsufficientFundsException implements Exception {
  final double amount;
  final double balance;

  InsufficientFundsException(this.amount, this.balance);

  @override
  String toString() =>
      'InsufficientFundsException: Required $amount, but balance is $balance';
}

/// Exception Handling in Dart
///
/// Exception vs Error:
/// - Exception: An exceptional event that occurs during program execution
///   * Can be caught and handled
///   * Usually indicates a recoverable problem
///   * Examples: FileNotFoundException, FormatException
///
/// - Error: A serious problem that should not be caught
///   * Indicates a programming error
///   * Usually cannot be recovered from
///   * Examples: OutOfMemoryError, StackOverflowError
///
/// Best Practices:
/// 1. Only catch exceptions you can handle
/// 2. Be specific with exception types
/// 3. Don't catch errors
/// 4. Clean up resources in finally blocks
/// 5. Use custom exceptions for domain-specific errors

void main() async {
  // 1. Basic try-catch block
  void demonstrateBasicTryCatch() {
    print('\n1. Basic try-catch block');
    try {
      // This will throw an exception
      int result = 10 ~/ 0; // Integer division by zero
      print('Result: $result');
    } catch (e) {
      print('Caught exception: $e');
    }
  }

  // 2. Using on for specific exceptions
  void demonstrateSpecificExceptions() {
    print('\n2. Specific exception handling');
    try {
      // Try to parse an invalid number
      int number = int.parse('abc');
      print('Number: $number');
    } on FormatException {
      print('Invalid number format');
    } on Exception catch (e) {
      print('Other exception: $e');
    }
  }

  // 3. Using finally block
  void demonstrateFinally() {
    print('\n3. Using finally block');
    File? file;
    try {
      file = File('test.txt');
      file.writeAsStringSync('Test content');
      print('File written successfully');
    } catch (e) {
      print('Error writing file: $e');
    } finally {
      // Clean up resources
      if (file != null && file.existsSync()) {
        file.deleteSync();
        print('File cleaned up');
      }
    }
  }

  // 4. Custom Exception
  void demonstrateCustomException() {
    print('\n4. Custom exception handling');
    double balance = 100.0;
    double withdrawAmount = 150.0;

    try {
      if (withdrawAmount > balance) {
        throw InsufficientFundsException(withdrawAmount, balance);
      }
      balance -= withdrawAmount;
      print('Withdrawal successful. New balance: $balance');
    } on InsufficientFundsException catch (e) {
      print('Error: $e');
    }
  }

  // 5. Handling asynchronous errors
  Future<void> demonstrateAsyncErrorHandling() async {
    print('\n5. Asynchronous error handling');
    try {
      // Simulate an async operation that might fail
      await Future.delayed(Duration(seconds: 1));
      throw Exception('Async operation failed');
    } catch (e) {
      print('Caught async error: $e');
    }
  }

  // 6. Multiple catch blocks with stack trace
  void demonstrateMultipleCatches() {
    print('\n6. Multiple catch blocks with stack trace');
    try {
      // Try to access an invalid index
      List<int> numbers = [1, 2, 3];
      print(numbers[5]);
    } on RangeError catch (e, stackTrace) {
      print('Range error: $e');
      print('Stack trace: $stackTrace');
    } catch (e, stackTrace) {
      print('Other error: $e');
      print('Stack trace: $stackTrace');
    }
  }

  // 7. Error handling with async/await
  Future<void> demonstrateAsyncAwaitErrorHandling() async {
    print('\n7. Error handling with async/await');
    try {
      // Simulate multiple async operations
      await Future.delayed(Duration(seconds: 1));
      await Future.error('Operation failed');
    } on TimeoutException {
      print('Operation timed out');
    } catch (e) {
      print('Async operation failed: $e');
    }
  }

  // 8. Rethrowing exceptions
  void demonstrateRethrowing() {
    print('\n8. Rethrowing exceptions');
    try {
      try {
        throw Exception('Inner exception');
      } catch (e) {
        print('Caught inner exception: $e');
        rethrow; // Rethrow the exception
      }
    } catch (e) {
      print('Caught rethrown exception: $e');
    }
  }

  // 9. Error handling with Future
  Future<void> demonstrateFutureErrorHandling() async {
    print('\n9. Error handling with Future');
    Future.delayed(
      Duration(seconds: 1),
    ).then((_) => throw Exception('Future error')).catchError((error) {
      print('Caught Future error: $error');
    });
  }

  // Run all examples
  demonstrateBasicTryCatch();
  demonstrateSpecificExceptions();
  demonstrateFinally();
  demonstrateCustomException();
  await demonstrateAsyncErrorHandling();
  demonstrateMultipleCatches();
  await demonstrateAsyncAwaitErrorHandling();
  demonstrateRethrowing();
  await demonstrateFutureErrorHandling();
}
