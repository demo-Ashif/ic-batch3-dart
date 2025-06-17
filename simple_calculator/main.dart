import 'dart:io';

void main() {
  print('🧮 Welcome to Simple Calculator! 🧮');
  print('This calculator supports: +, -, *, /');

  // Main program loop
  while (true) {
    performCalculation();

    // Ask if user wants to continue
    print('\nWould you like to perform another calculation? (y/n): ');
    String? continueCalc = stdin.readLineSync()?.toLowerCase();

    if (continueCalc != 'y' && continueCalc != 'yes') {
      print('Thanks for using the calculator! 👋');
      break;
    }
  }
}

void performCalculation() {
  print('\n--- New Calculation ---');

  // Get first number
  double? num1 = getNumber('Enter first number: ');
  if (num1 == null) return;

  // Get operator
  String? operator = getOperator();
  if (operator == null) return;

  // Get second number
  double? num2 = getNumber('Enter second number: ');
  if (num2 == null) return;

  // Perform calculation
  double? result = calculate(num1, operator, num2);

  // Display result
  if (result != null) {
    print('\n📊 Result: $num1 $operator $num2 = $result');
  }
}

double? getNumber(String prompt) {
  while (true) {
    print(prompt);
    String? input = stdin.readLineSync();

    // Input validation
    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid number!');
      continue;
    }

    double? number = double.tryParse(input);
    if (number == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    return number;
  }
}

String? getOperator() {
  while (true) {
    print('Enter operator (+, -, *, /): ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid operator!');
      continue;
    }

    // Check if operator is valid
    if (['+', '-', '*', '/'].contains(input)) {
      return input;
    } else {
      print('❌ Please enter a valid operator (+, -, *, /)!');
    }
  }
}

double? calculate(double num1, String operator, double num2) {
  switch (operator) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    case '*':
      return num1 * num2;
    case '/':
      // Check for division by zero
      if (num2 == 0) {
        print('❌ Error: Cannot divide by zero!');
        return null;
      }
      return num1 / num2;
    default:
      print('❌ Invalid operator!');
      return null;
  }
}
