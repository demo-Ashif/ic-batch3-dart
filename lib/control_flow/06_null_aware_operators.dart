// Example of null-aware operators in Dart
// This file demonstrates the usage of ?? and ??= operators

void main() {
  // Example 1: Basic null-aware operator (??)
  String? name;

  print('Example 1: Basic null-aware operator (??)');
  String greeting = name ?? 'Guest';
  print('Hello, $greeting!');

  // Example 2: Null-aware operator with non-null value
  String? title = 'Mr.';

  print('\nExample 2: Null-aware operator with non-null value');
  String fullName = title ?? 'Mr.';
  print('Hello, $fullName Smith!');

  // Example 3: Null-aware assignment operator (??=)
  String? message;

  print('\nExample 3: Null-aware assignment operator (??=)');
  message ??= 'Default message';
  print('Message: $message');

  // Example 4: Null-aware operator with function calls
  String? userInput;

  print('\nExample 4: Null-aware operator with function calls');
  String displayName = userInput ?? getUserName();
  print('Welcome, $displayName!');

  // Example 5: Chaining null-aware operators
  String? firstName;
  String? lastName;

  print('\nExample 5: Chaining null-aware operators');
  String fullName2 = '${firstName ?? 'John'} ${lastName ?? 'Doe'}';
  print('Full name: $fullName2');

  // Example 6: Null-aware operator with lists
  List<int>? numbers;

  print('\nExample 6: Null-aware operator with lists');
  List<int> safeNumbers = numbers ?? [1, 2, 3];
  print('Numbers: $safeNumbers');

  // Example 7: Null-aware operator with maps
  Map<String, String>? userData;

  print('\nExample 7: Null-aware operator with maps');
  Map<String, String> safeUserData =
      userData ?? {'name': 'Guest', 'role': 'user'};
  print('User data: $safeUserData');

  // Example 8: Complex null-aware operations
  String? email;
  String? phone;

  print('\nExample 8: Complex null-aware operations');
  String contactInfo = email ?? phone ?? 'No contact information available';
  print('Contact: $contactInfo');
}

// Helper function for Example 4
String getUserName() {
  return 'Default User';
}
