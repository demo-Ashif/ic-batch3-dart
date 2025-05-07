// Example of switch-case statements in Dart
// This file demonstrates the usage of switch-case statements

// Define enum outside of main function
enum Direction { north, south, east, west }

void main() {
  // Example 1: Basic switch-case with numbers
  int day = 3;

  print('Example 1: Basic switch-case with numbers');
  switch (day) {
    case 1:
      print('Monday');
      break;
    case 2:
      print('Tuesday');
      break;
    case 3:
      print('Wednesday');
      break;
    case 4:
      print('Thursday');
      break;
    case 5:
      print('Friday');
      break;
    case 6:
    case 7:
      print('Weekend');
      break;
    default:
      print('Invalid day');
  }

  // Example 2: Switch-case with strings
  String grade = 'B';

  print('\nExample 2: Switch-case with strings');
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
    case 'D':
      print('Needs improvement');
      break;
    case 'F':
      print('Failed');
      break;
    default:
      print('Invalid grade');
  }

  // Example 3: Switch-case with enum
  Direction direction = Direction.north;

  print('\nExample 3: Switch-case with enum');
  switch (direction) {
    case Direction.north:
      print('Going north');
      break;
    case Direction.south:
      print('Going south');
      break;
    case Direction.east:
      print('Going east');
      break;
    case Direction.west:
      print('Going west');
      break;
  }

  // Example 4: Switch-case with multiple cases
  int month = 2;

  print('\nExample 4: Switch-case with multiple cases');
  switch (month) {
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      print('31 days');
      break;
    case 4:
    case 6:
    case 9:
    case 11:
      print('30 days');
      break;
    case 2:
      print('28 or 29 days');
      break;
    default:
      print('Invalid month');
  }

  // Example 5: Switch-case with expressions
  int number = 15;

  print('\nExample 5: Switch-case with expressions');
  switch (number % 2) {
    case 0:
      print('Even number');
      break;
    case 1:
      print('Odd number');
      break;
  }

  // Example 6: Switch-case with continue
  int value = 1;

  print('\nExample 6: Switch-case with continue');
  switch (value) {
    case 1:
      print('One');
      continue two;
    two:
    case 2:
      print('Two');
      break;
    default:
      print('Other');
  }

  // Example 7: Switch-case with return
  String status = 'active';

  print('\nExample 7: Switch-case with return');
  String getStatusMessage() {
    switch (status) {
      case 'active':
        return 'User is active';
      case 'inactive':
        return 'User is inactive';
      case 'pending':
        return 'User is pending';
      default:
        return 'Unknown status';
    }
  }

  print(getStatusMessage());
}
