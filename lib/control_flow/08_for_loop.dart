// Example of for loops in Dart
// This file demonstrates the usage of for loops

void main() {
  // Example 1: Basic for loop
  print('Example 1: Basic for loop');
  for (int i = 1; i <= 5; i++) {
    print('Count: $i');
  }

  // Example 2: For loop with step
  print('\nExample 2: For loop with step');
  for (int i = 0; i <= 10; i += 2) {
    print('Even number: $i');
  }

  // Example 3: For loop with decrement
  print('\nExample 3: For loop with decrement');
  for (int i = 5; i > 0; i--) {
    print('Countdown: $i');
  }

  // Example 4: For loop with multiple variables
  print('\nExample 4: For loop with multiple variables');
  for (int i = 1, j = 10; i <= 5; i++, j--) {
    print('i: $i, j: $j');
  }

  // Example 5: For loop with break
  print('\nExample 5: For loop with break');
  for (int i = 1; i <= 10; i++) {
    if (i == 6) {
      break;
    }
    print('Number: $i');
  }

  // Example 6: For loop with continue
  print('\nExample 6: For loop with continue');
  for (int i = 1; i <= 5; i++) {
    if (i == 3) {
      continue;
    }
    print('Number: $i');
  }

  // Example 7: Nested for loops
  print('\nExample 7: Nested for loops');
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      print('i: $i, j: $j');
    }
  }

  // Example 8: For loop with list
  List<int> numbers = [1, 2, 3, 4, 5];

  print('\nExample 8: For loop with list');
  for (int i = 0; i < numbers.length; i++) {
    print('Number at index $i: ${numbers[i]}');
  }

  // Example 9: For loop with string
  String text = 'Hello';

  print('\nExample 9: For loop with string');
  for (int i = 0; i < text.length; i++) {
    print('Character at index $i: ${text[i]}');
  }

  // Example 10: For loop with condition
  print('\nExample 10: For loop with condition');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      print('$i is even');
    } else {
      print('$i is odd');
    }
  }
}
