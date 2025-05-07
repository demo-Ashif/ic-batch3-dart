// Example of switch-case statements in Dart
// This file demonstrates the usage of switch-case statements

import 'dart:io';

// Define enum outside of main function
enum Direction { north, south, east, west }

void main() {
  // Example 1: Basic switch-case with numbers
  print('\nExample 1: Basic switch-case with numbers');
  print('Enter a number between 1 and 7 to get the day of the week:');
  int? day = int.tryParse(stdin.readLineSync() ?? '0');

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
  print('\nExample 2: Switch-case with strings');
  print('Enter a grade (A, B, C, D, or F):');
  String? grade = stdin.readLineSync()?.toUpperCase();

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
  print('\nExample 3: Switch-case with enum');
  print('Enter a direction (north, south, east, or west):');
  String? directionInput = stdin.readLineSync()?.toLowerCase();
  Direction? direction;

  switch (directionInput) {
    case 'north':
      direction = Direction.north;
      break;
    case 'south':
      direction = Direction.south;
      break;
    case 'east':
      direction = Direction.east;
      break;
    case 'west':
      direction = Direction.west;
      break;
    default:
      print('Invalid direction');
      return;
  }

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
  print('\nExample 4: Switch-case with multiple cases');
  print('Enter a month number (1-12):');
  int? month = int.tryParse(stdin.readLineSync() ?? '0');

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
  print('\nExample 5: Switch-case with expressions');
  print('Enter a number to check if it\'s even or odd:');
  int? number = int.tryParse(stdin.readLineSync() ?? '0');

  if (number != null) {
    switch (number % 2) {
      case 0:
        print('Even number');
        break;
      case 1:
        print('Odd number');
        break;
    }
  } else {
    print('Invalid input');
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
