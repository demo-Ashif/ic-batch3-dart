// Example of for-in loops in Dart
// This file demonstrates the usage of for-in loops for iterating over collections

// Define enum outside of main function
enum Color { red, green, blue }

void main() {
  // Example 1: For-in loop with list
  List<int> numbers = [1, 2, 3, 4, 5];

  print('Example 1: For-in loop with list');
  for (int number in numbers) {
    print('Number: $number');
  }

  // Example 2: For-in loop with string
  String text = 'Hello';

  print('\nExample 2: For-in loop with string');
  for (String char in text.split('')) {
    print('Character: $char');
  }

  // Example 3: For-in loop with set
  Set<String> fruits = {'apple', 'banana', 'orange'};

  print('\nExample 3: For-in loop with set');
  for (String fruit in fruits) {
    print('Fruit: $fruit');
  }

  // Example 4: For-in loop with map
  Map<String, int> scores = {'John': 85, 'Alice': 92, 'Bob': 78};

  print('\nExample 4: For-in loop with map');
  for (String name in scores.keys) {
    print('$name scored ${scores[name]}');
  }

  // Example 5: For-in loop with map entries
  print('\nExample 5: For-in loop with map entries');
  for (MapEntry<String, int> entry in scores.entries) {
    print('${entry.key} scored ${entry.value}');
  }

  // Example 6: For-in loop with list of objects
  List<Map<String, dynamic>> students = [
    {'name': 'John', 'age': 20, 'grade': 'A'},
    {'name': 'Alice', 'age': 19, 'grade': 'B'},
    {'name': 'Bob', 'age': 21, 'grade': 'A'},
  ];

  print('\nExample 6: For-in loop with list of objects');
  for (Map<String, dynamic> student in students) {
    print(
      '${student['name']} is ${student['age']} years old and got grade ${student['grade']}',
    );
  }

  // Example 7: For-in loop with break
  print('\nExample 7: For-in loop with break');
  for (int number in numbers) {
    if (number == 4) {
      break;
    }
    print('Number: $number');
  }

  // Example 8: For-in loop with continue
  print('\nExample 8: For-in loop with continue');
  for (int number in numbers) {
    if (number == 3) {
      continue;
    }
    print('Number: $number');
  }

  // Example 9: For-in loop with nested lists
  List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];

  print('\nExample 9: For-in loop with nested lists');
  for (List<int> row in matrix) {
    for (int number in row) {
      print('Number: $number');
    }
  }

  // Example 10: For-in loop with enum
  print('\nExample 10: For-in loop with enum');
  for (Color color in Color.values) {
    print('Color: $color');
  }
}
