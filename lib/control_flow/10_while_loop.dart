// Example of while loops in Dart
// This file demonstrates the usage of while loops

void main() {
  // Example 1: Basic while loop
  int count = 1;

  print('Example 1: Basic while loop');
  while (count <= 5) {
    print('Count: $count');
    count++;
  }

  // Example 2: While loop with condition
  int number = 1;

  print('\nExample 2: While loop with condition');
  while (number <= 10) {
    if (number % 2 == 0) {
      print('$number is even');
    } else {
      print('$number is odd');
    }
    number++;
  }

  // Example 3: While loop with break
  int i = 1;

  print('\nExample 3: While loop with break');
  while (true) {
    if (i > 5) {
      break;
    }
    print('Number: $i');
    i++;
  }

  // Example 4: While loop with continue
  int j = 0;

  print('\nExample 4: While loop with continue');
  while (j < 5) {
    j++;
    if (j == 3) {
      continue;
    }
    print('Number: $j');
  }

  // Example 5: While loop with list
  List<int> numbers = [1, 2, 3, 4, 5];
  int index = 0;

  print('\nExample 5: While loop with list');
  while (index < numbers.length) {
    print('Number at index $index: ${numbers[index]}');
    index++;
  }

  // Example 6: While loop with string
  String text = 'Hello';
  int charIndex = 0;

  print('\nExample 6: While loop with string');
  while (charIndex < text.length) {
    print('Character at index $charIndex: ${text[charIndex]}');
    charIndex++;
  }

  // Example 7: While loop with multiple conditions
  int x = 1;
  int y = 10;

  print('\nExample 7: While loop with multiple conditions');
  while (x <= 5 && y >= 5) {
    print('x: $x, y: $y');
    x++;
    y--;
  }

  // Example 8: While loop with user input simulation
  int attempts = 0;
  int maxAttempts = 3;
  bool isCorrect = false;

  print('\nExample 8: While loop with user input simulation');
  while (attempts < maxAttempts && !isCorrect) {
    print('Attempt ${attempts + 1} of $maxAttempts');
    // Simulating user input
    if (attempts == 2) {
      isCorrect = true;
    }
    attempts++;
  }

  // Example 9: While loop with nested conditions
  int row = 1;

  print('\nExample 9: While loop with nested conditions');
  while (row <= 3) {
    int col = 1;
    while (col <= 3) {
      print('Position: ($row, $col)');
      col++;
    }
    row++;
  }

  // Example 10: While loop with complex condition
  int value = 1;
  int sum = 0;

  print('\nExample 10: While loop with complex condition');
  while (value <= 10 && sum < 30) {
    sum += value;
    print('Current value: $value, Sum: $sum');
    value++;
  }
}
