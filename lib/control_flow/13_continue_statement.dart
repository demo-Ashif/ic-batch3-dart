// Example of continue statements in Dart
// This file demonstrates the usage of continue statements in different contexts

void main() {
  // Example 1: Continue in for loop
  print('Example 1: Continue in for loop');
  for (int i = 1; i <= 5; i++) {
    if (i == 3) {
      continue;
    }
    print('Number: $i');
  }

  // Example 2: Continue in while loop
  int count = 0;

  print('\nExample 2: Continue in while loop');
  while (count < 5) {
    count++;
    if (count == 3) {
      continue;
    }
    print('Count: $count');
  }

  // Example 3: Continue in do-while loop
  int number = 0;

  print('\nExample 3: Continue in do-while loop');
  do {
    number++;
    if (number == 3) {
      continue;
    }
    print('Number: $number');
  } while (number < 5);

  // Example 4: Continue in nested loops
  print('\nExample 4: Continue in nested loops');
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        continue;
      }
      print('i: $i, j: $j');
    }
  }

  // Example 5: Continue with label
  print('\nExample 5: Continue with label');
  outerLoop:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        continue outerLoop;
      }
      print('i: $i, j: $j');
    }
  }

  // Example 6: Continue with condition
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  print('\nExample 6: Continue with condition');
  for (int number in numbers) {
    if (number % 2 == 0) {
      continue;
    }
    print('Odd number: $number');
  }

  // Example 7: Continue with multiple conditions
  print('\nExample 7: Continue with multiple conditions');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0 || i % 3 == 0) {
      continue;
    }
    print('Number not divisible by 2 or 3: $i');
  }

  // Example 8: Continue in complex scenario
  List<Map<String, dynamic>> students = [
    {'name': 'John', 'grade': 'A'},
    {'name': 'Alice', 'grade': 'B'},
    {'name': 'Bob', 'grade': 'C'},
    {'name': 'Emma', 'grade': 'A'},
  ];

  print('\nExample 8: Continue in complex scenario');
  for (var student in students) {
    if (student['grade'] != 'A') {
      continue;
    }
    print('Student with grade A: ${student['name']}');
  }

  // Example 9: Continue with string processing
  String text = 'Hello World';

  print('\nExample 9: Continue with string processing');
  for (int i = 0; i < text.length; i++) {
    if (text[i] == ' ') {
      continue;
    }
    print('Character: ${text[i]}');
  }

  // Example 10: Continue with list filtering
  List<int> values = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int sum = 0;

  print('\nExample 10: Continue with list filtering');
  for (int value in values) {
    if (value % 2 == 0) {
      continue;
    }
    sum += value;
    print('Current sum: $sum');
  }
}
