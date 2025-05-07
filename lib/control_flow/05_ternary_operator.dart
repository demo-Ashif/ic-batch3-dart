// Example of ternary operator in Dart
// This file demonstrates the usage of the ternary operator (condition ? expr1 : expr2)

void main() {
  // Example 1: Basic ternary operator
  int age = 20;

  print('Example 1: Basic ternary operator');
  String message = age >= 18 ? 'Adult' : 'Minor';
  print('Status: $message');

  // Example 2: Ternary operator with string concatenation
  String name = 'John';

  print('\nExample 2: Ternary operator with string concatenation');
  print('Hello, ${name == 'John' ? 'Mr. John' : name}!');

  // Example 3: Nested ternary operators
  int score = 85;

  print('\nExample 3: Nested ternary operators');
  String grade =
      score >= 90
          ? 'A'
          : score >= 80
          ? 'B'
          : score >= 70
          ? 'C'
          : score >= 60
          ? 'D'
          : 'F';
  print('Grade: $grade');

  // Example 4: Ternary operator with boolean
  bool isRaining = true;

  print('\nExample 4: Ternary operator with boolean');
  print(isRaining ? 'Take an umbrella' : 'Enjoy the sunshine');

  // Example 5: Ternary operator with number operations
  int number = 10;

  print('\nExample 5: Ternary operator with number operations');
  int result = number > 5 ? number * 2 : number + 5;
  print('Result: $result');

  // Example 6: Ternary operator with list operations
  List<int> numbers = [1, 2, 3];

  print('\nExample 6: Ternary operator with list operations');
  print(numbers.isEmpty ? 'List is empty' : 'List has ${numbers.length} items');

  // Example 7: Ternary operator with null check
  String? nullableName;

  print('\nExample 7: Ternary operator with null check');
  print(nullableName != null ? 'Hello, $nullableName!' : 'Hello, Guest!');

  // Example 8: Ternary operator with multiple conditions
  int time = 14;
  bool isWeekend = false;

  print('\nExample 8: Ternary operator with multiple conditions');
  print(
    isWeekend
        ? 'Weekend!'
        : time < 12
        ? 'Good morning!'
        : time < 17
        ? 'Good afternoon!'
        : time < 21
        ? 'Good evening!'
        : 'Good night!',
  );
}
