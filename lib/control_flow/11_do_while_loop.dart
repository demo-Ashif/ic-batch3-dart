// Example of do-while loops in Dart
// This file demonstrates the usage of do-while loops

void main() {
  // Example 1: Basic do-while loop
  int count = 1;

  print('Example 1: Basic do-while loop');
  do {
    print('Count: $count');
    count++;
  } while (count <= 5);

  // Example 2: Do-while loop with condition
  int number = 1;

  print('\nExample 2: Do-while loop with condition');
  do {
    if (number % 2 == 0) {
      print('$number is even');
    } else {
      print('$number is odd');
    }
    number++;
  } while (number <= 10);

  // Example 3: Do-while loop with break
  int i = 1;

  print('\nExample 3: Do-while loop with break');
  do {
    if (i > 5) {
      break;
    }
    print('Number: $i');
    i++;
  } while (true);

  // Example 4: Do-while loop with continue
  int j = 0;

  print('\nExample 4: Do-while loop with continue');
  do {
    j++;
    if (j == 3) {
      continue;
    }
    print('Number: $j');
  } while (j < 5);

  // Example 5: Do-while loop with list
  List<int> numbers = [1, 2, 3, 4, 5];
  int index = 0;

  print('\nExample 5: Do-while loop with list');
  do {
    print('Number at index $index: ${numbers[index]}');
    index++;
  } while (index < numbers.length);

  // Example 6: Do-while loop with string
  String text = 'Hello';
  int charIndex = 0;

  print('\nExample 6: Do-while loop with string');
  do {
    print('Character at index $charIndex: ${text[charIndex]}');
    charIndex++;
  } while (charIndex < text.length);

  // Example 7: Do-while loop with multiple conditions
  int x = 1;
  int y = 10;

  print('\nExample 7: Do-while loop with multiple conditions');
  do {
    print('x: $x, y: $y');
    x++;
    y--;
  } while (x <= 5 && y >= 5);

  // Example 8: Do-while loop with user input simulation
  int attempts = 0;
  int maxAttempts = 3;
  bool isCorrect = false;

  print('\nExample 8: Do-while loop with user input simulation');
  do {
    print('Attempt ${attempts + 1} of $maxAttempts');
    // Simulating user input
    if (attempts == 2) {
      isCorrect = true;
    }
    attempts++;
  } while (attempts < maxAttempts && !isCorrect);

  // Example 9: Do-while loop with nested conditions
  int row = 1;

  print('\nExample 9: Do-while loop with nested conditions');
  do {
    int col = 1;
    do {
      print('Position: ($row, $col)');
      col++;
    } while (col <= 3);
    row++;
  } while (row <= 3);

  // Example 10: Do-while loop with complex condition
  int value = 1;
  int sum = 0;

  print('\nExample 10: Do-while loop with complex condition');
  do {
    sum += value;
    print('Current value: $value, Sum: $sum');
    value++;
  } while (value <= 10 && sum < 30);
}
