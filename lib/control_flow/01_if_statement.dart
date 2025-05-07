// Example of if statements in Dart
// This file demonstrates the basic usage of if statements

void main() {
  // Example 1: Simple if statement
  int age = 18;

  print('Example 1: Simple if statement');
  if (age >= 18) {
    print('You are an adult');
  }

  // Example 2: if with multiple conditions
  int temperature = 25;
  bool isRaining = true;

  print('\nExample 2: if with multiple conditions');
  if (temperature > 20 && isRaining) {
    print('It\'s warm but raining');
  }

  // Example 3: if with comparison operators
  int number = 10;

  print('\nExample 3: if with comparison operators');
  if (number == 10) {
    print('Number is exactly 10');
  }
  if (number != 5) {
    print('Number is not 5');
  }
  if (number > 5) {
    print('Number is greater than 5');
  }

  // Example 4: if with string comparison
  String name = 'John';

  print('\nExample 4: if with string comparison');
  if (name == 'John') {
    print('Hello, John!');
  }

  // Example 5: if with list check
  List<int> numbers = [1, 2, 3];

  print('\nExample 5: if with list check');
  if (numbers.isNotEmpty) {
    print('The list has ${numbers.length} items');
  }
}
