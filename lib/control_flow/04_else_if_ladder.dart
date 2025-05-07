// Example of else-if ladder in Dart
// This file demonstrates the usage of else-if ladder statements

void main() {
  // Example 1: Basic else-if ladder with numbers
  int score = 85;

  print('Example 1: Basic else-if ladder with numbers');
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else if (score >= 70) {
    print('Grade: C');
  } else if (score >= 60) {
    print('Grade: D');
  } else {
    print('Grade: F');
  }

  // Example 2: else-if ladder with temperature ranges
  int temperature = 25;

  print('\nExample 2: else-if ladder with temperature ranges');
  if (temperature > 30) {
    print('It\'s hot outside');
  } else if (temperature > 25) {
    print('It\'s warm outside');
  } else if (temperature > 20) {
    print('It\'s pleasant outside');
  } else if (temperature > 15) {
    print('It\'s cool outside');
  } else {
    print('It\'s cold outside');
  }

  // Example 3: else-if ladder with string comparison
  String day = 'Wednesday';

  print('\nExample 3: else-if ladder with string comparison');
  if (day == 'Monday') {
    print('Start of the week');
  } else if (day == 'Tuesday') {
    print('Second day of the week');
  } else if (day == 'Wednesday') {
    print('Middle of the week');
  } else if (day == 'Thursday') {
    print('Almost weekend');
  } else if (day == 'Friday') {
    print('Last working day');
  } else {
    print('Weekend!');
  }

  // Example 4: else-if ladder with age ranges
  int age = 25;

  print('\nExample 4: else-if ladder with age ranges');
  if (age < 13) {
    print('Child');
  } else if (age < 20) {
    print('Teenager');
  } else if (age < 30) {
    print('Young adult');
  } else if (age < 50) {
    print('Adult');
  } else {
    print('Senior');
  }

  // Example 5: else-if ladder with multiple conditions
  int time = 14;
  bool isWeekend = false;

  print('\nExample 5: else-if ladder with multiple conditions');
  if (isWeekend) {
    print('It\'s weekend!');
  } else if (time < 12) {
    print('Good morning!');
  } else if (time < 17) {
    print('Good afternoon!');
  } else if (time < 21) {
    print('Good evening!');
  } else {
    print('Good night!');
  }
}
