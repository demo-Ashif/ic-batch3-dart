// Example of nested if-else statements in Dart
// This file demonstrates the usage of nested if-else statements

void main() {
  // Example 1: Basic nested if-else
  int age = 20;
  bool hasId = true;

  print('Example 1: Basic nested if-else');
  if (age >= 18) {
    if (hasId) {
      print('You can enter the venue');
    } else {
      print('You need to show ID');
    }
  } else {
    print('You are too young to enter');
  }

  // Example 2: Nested if-else with multiple conditions
  int temperature = 25;
  bool isRaining = true;
  bool hasUmbrella = false;

  print('\nExample 2: Nested if-else with multiple conditions');
  if (temperature > 20) {
    if (isRaining) {
      if (hasUmbrella) {
        print('You can go outside with your umbrella');
      } else {
        print('You should stay inside or get an umbrella');
      }
    } else {
      print('It\'s a nice day to go outside');
    }
  } else {
    print('It\'s too cold to go outside');
  }

  // Example 3: Nested if-else with number ranges
  int score = 85;
  bool isPassing = true;

  print('\nExample 3: Nested if-else with number ranges');
  if (score >= 70) {
    if (score >= 90) {
      print('Excellent! You got an A');
    } else if (score >= 80) {
      print('Good job! You got a B');
    } else {
      print('You passed with a C');
    }
  } else {
    print('You need to retake the exam');
  }

  // Example 4: Nested if-else with string and number conditions
  String name = 'John';
  int age2 = 25;

  print('\nExample 4: Nested if-else with string and number conditions');
  if (name == 'John') {
    if (age2 >= 21) {
      print('Welcome, John! You can enter the bar');
    } else {
      print('Sorry, John. You are too young to enter the bar');
    }
  } else {
    print('Sorry, this is a private event for John');
  }

  // Example 5: Nested if-else with list operations
  List<int> numbers = [1, 2, 3];
  int searchNumber = 2;

  print('\nExample 5: Nested if-else with list operations');
  if (numbers.isNotEmpty) {
    if (numbers.contains(searchNumber)) {
      print('Found $searchNumber in the list');
    } else {
      print('$searchNumber is not in the list');
    }
  } else {
    print('The list is empty');
  }
}
