# Frequently Asked Questions (FAQ)

## File System Questions

### Q: What is the difference between `File` and `Directory` in Dart?
**A:** 
- `File` represents a file in the file system and is used for reading/writing file contents
- `Directory` represents a folder and is used for managing files and subdirectories
- Both are part of the `dart:io` library and are used for file system operations

### Q: How do I handle file paths across different operating systems?
**A:** 
- Use the `path` package from pub.dev
- Use `path.join()` instead of string concatenation
- Avoid hardcoding path separators (/, \)
- Use `Platform.pathSeparator` when needed
- Example:
  ```dart
  import 'package:path/path.dart' as path;
  final filePath = path.join('folder', 'subfolder', 'file.txt');
  ```

### Q: What's the difference between synchronous and asynchronous file operations?
**A:**
- Synchronous operations (e.g., `readAsStringSync()`) block the program until complete
- Asynchronous operations (e.g., `readAsString()`) allow other code to run while waiting
- Use async operations for better performance and responsiveness
- Use sync operations only when necessary (e.g., during program startup)

### Q: How do I read a large file without loading it all into memory?
**A:**
```dart
final file = File('large_file.txt');
await for (String line in file.openRead()
    .transform(utf8.decoder)
    .transform(LineSplitter())) {
  // Process one line at a time
  print(line);
}
```

## Exception Handling Questions

### Q: What's the difference between `try-catch` and `try-on`?
**A:**
- `try-catch` catches all exceptions
- `try-on` catches specific types of exceptions
- Use `on` when you know the specific exception type
- Use `catch` for general exception handling
- Example:
  ```dart
  try {
    // code
  } on FormatException {
    // handle format exception
  } catch (e) {
    // handle other exceptions
  }
  ```

### Q: When should I create custom exceptions?
**A:**
- When you need to represent domain-specific errors
- When you want to add additional information to exceptions
- When you need to distinguish between different types of errors
- Example:
  ```dart
  class InsufficientFundsException implements Exception {
    final double amount;
    final double balance;
    InsufficientFundsException(this.amount, this.balance);
  }
  ```

### Q: How do I handle exceptions in async code?
**A:**
```dart
try {
  await someAsyncOperation();
} catch (e) {
  // Handle exception
} finally {
  // Clean up
}
```

### Q: What's the purpose of the `finally` block?
**A:**
- Executes regardless of whether an exception occurs
- Used for cleanup operations (closing files, connections)
- Always runs, even if there's a return statement
- Example:
  ```dart
  File? file;
  try {
    file = File('test.txt');
    // operations
  } finally {
    file?.close();
  }
  ```

### Q: How do I handle multiple exceptions?
**A:**
```dart
try {
  // code
} on FormatException {
  // handle format exception
} on FileSystemException {
  // handle file system exception
} catch (e) {
  // handle other exceptions
}
```

### Q: What's the difference between `throw` and `rethrow`?
**A:**
- `throw` creates a new exception
- `rethrow` passes the current exception up the call stack
- Use `rethrow` when you want to log an exception but let the caller handle it
- Example:
  ```dart
  try {
    // code
  } catch (e) {
    print('Error occurred: $e');
    rethrow; // Let caller handle the exception
  }
  ```

### Q: How do I handle exceptions in Future chains?
**A:**
```dart
Future.delayed(Duration(seconds: 1))
    .then((_) => throw Exception('Error'))
    .catchError((error) {
      print('Caught error: $error');
    });
```

### Q: What's the best way to log exceptions?
**A:**
- Include the stack trace
- Add context information
- Use appropriate log levels
- Example:
  ```dart
  try {
    // code
  } catch (e, stackTrace) {
    print('Error: $e');
    print('Stack trace: $stackTrace');
  }
  ```

### Q: How do I handle file not found exceptions?
**A:**
```dart
try {
  final file = File('nonexistent.txt');
  await file.readAsString();
} on FileSystemException catch (e) {
  if (e.osError?.errorCode == 2) { // File not found
    print('File not found');
  } else {
    rethrow;
  }
}
```

### Q: What's the difference between `Error` and `Exception`?
**A:**
- `Exception`: Represents recoverable problems
- `Error`: Represents serious problems that shouldn't be caught
- Examples:
  - `Exception`: `FormatException`, `FileNotFoundException`
  - `Error`: `OutOfMemoryError`, `StackOverflowError`

### Q: How do I create a custom exception with additional data?
**A:**
```dart
class ValidationException implements Exception {
  final String field;
  final String message;
  final dynamic value;

  ValidationException(this.field, this.message, this.value);

  @override
  String toString() => 'ValidationException: $field - $message (value: $value)';
}
```

### Q: How do I handle timeouts in async operations?
**A:**
```dart
try {
  await Future.delayed(Duration(seconds: 5))
      .timeout(Duration(seconds: 2));
} on TimeoutException {
  print('Operation timed out');
}
```

Remember:
1. Always handle exceptions appropriately
2. Clean up resources in finally blocks
3. Provide meaningful error messages
4. Log exceptions for debugging
5. Use specific exception types when possible
6. Consider the user experience when handling errors 