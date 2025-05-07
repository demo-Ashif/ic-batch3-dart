// Example of if-else statements in Dart
// This file demonstrates the usage of if-else statements

void main() {
  // Example 1: Basic if-else
  int age = 15;

  print('Example 1: Basic if-else');
  if (age >= 18) {
    print('You are an adult');
  } else {
    print('You are a minor');
  }

  // Example 2: if-else with multiple conditions
  int temperature = 25;
  bool isRaining = true;

  print('\nExample 2: if-else with multiple conditions');
  if (temperature > 30) {
    print('It\'s hot outside');
  } else if (temperature > 20) {
    print('It\'s warm outside');
  } else {
    print('It\'s cold outside');
  }

  // Example 3: if-else with string comparison
  String name = 'Alice';

  print('\nExample 3: if-else with string comparison');
  if (name == 'John') {
    print('Hello, John!');
  } else {
    print('Hello, $name!');
  }

  // Example 4: if-else with number range
  int score = 85;

  print('\nExample 4: if-else with number range');
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else if (score >= 70) {
    print('Grade: C');
  } else {
    print('Grade: F');
  }

  // Example 5: if-else with list operations
  List<int> numbers = [];

  print('\nExample 5: if-else with list operations');
  if (numbers.isEmpty) {
    print('The list is empty');
  } else {
    print('The list has ${numbers.length} items');
  }
}
