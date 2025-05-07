// Example of break statements in Dart
// This file demonstrates the usage of break statements in different contexts

void main() {
  // Example 1: Break in for loop
  print('Example 1: Break in for loop');
  for (int i = 1; i <= 10; i++) {
    if (i == 6) {
      break;
    }
    print('Number: $i');
  }

  // Example 2: Break in while loop
  int count = 1;

  print('\nExample 2: Break in while loop');
  while (true) {
    if (count > 5) {
      break;
    }
    print('Count: $count');
    count++;
  }

  // Example 3: Break in do-while loop
  int number = 1;

  print('\nExample 3: Break in do-while loop');
  do {
    if (number > 5) {
      break;
    }
    print('Number: $number');
    number++;
  } while (true);

  // Example 4: Break in nested loops
  print('\nExample 4: Break in nested loops');
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        break;
      }
      print('i: $i, j: $j');
    }
  }

  // Example 5: Break with label
  print('\nExample 5: Break with label');
  outerLoop:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (i == 2 && j == 2) {
        break outerLoop;
      }
      print('i: $i, j: $j');
    }
  }

  // Example 6: Break in switch statement
  String grade = 'B';

  print('\nExample 6: Break in switch statement');
  switch (grade) {
    case 'A':
      print('Excellent!');
      break;
    case 'B':
      print('Good job!');
      break;
    case 'C':
      print('Satisfactory');
      break;
    default:
      print('Needs improvement');
  }

  // Example 7: Break with condition
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  print('\nExample 7: Break with condition');
  for (int number in numbers) {
    if (number > 5) {
      break;
    }
    print('Number: $number');
  }

  // Example 8: Break in infinite loop
  int counter = 0;

  print('\nExample 8: Break in infinite loop');
  while (true) {
    counter++;
    if (counter > 5) {
      break;
    }
    print('Counter: $counter');
  }

  // Example 9: Break with multiple conditions
  int value = 1;

  print('\nExample 9: Break with multiple conditions');
  while (true) {
    if (value > 10 || value % 3 == 0) {
      break;
    }
    print('Value: $value');
    value++;
  }

  // Example 10: Break in complex scenario
  List<Map<String, dynamic>> students = [
    {'name': 'John', 'grade': 'A'},
    {'name': 'Alice', 'grade': 'B'},
    {'name': 'Bob', 'grade': 'C'},
    {'name': 'Emma', 'grade': 'A'},
  ];

  print('\nExample 10: Break in complex scenario');
  for (var student in students) {
    if (student['grade'] == 'C') {
      print('Found student with grade C: ${student['name']}');
      break;
    }
  }
}
