import 'dart:io';

void main() {
  print('📊 Welcome to BMI Calculator! 📊');
  print('Calculate your Body Mass Index (BMI)');

  // Main program loop
  while (true) {
    calculateBMI();

    // Ask if user wants to calculate again
    print('\nWould you like to calculate another BMI? (y/n): ');
    String? continueCalc = stdin.readLineSync()?.toLowerCase();

    if (continueCalc != 'y' && continueCalc != 'yes') {
      print('👋 Thanks for using BMI Calculator!');
      break;
    }
  }
}

void calculateBMI() {
  print('\n--- BMI Calculation ---');

  // Get weight in kg
  double? weight = getWeight();
  if (weight == null) return;

  // Get height in inches
  double? height = getHeight();
  if (height == null) return;

  // Calculate BMI
  double bmi = calculateBMIScore(weight, height);

  // Get BMI category
  String category = getBMICategory(bmi);

  // Display results
  print('\n📊 BMI Results:');
  print('Weight: ${weight.toStringAsFixed(1)} kg');
  print('Height: ${height.toStringAsFixed(1)} inches');
  print('BMI: ${bmi.toStringAsFixed(1)}');
  print('Category: $category');
}

double? getWeight() {
  while (true) {
    print('Enter your weight in kg: ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid weight!');
      continue;
    }

    double? weight = double.tryParse(input);
    if (weight == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    if (weight <= 0 || weight > 500) {
      print('❌ Please enter a realistic weight (1-500 kg)!');
      continue;
    }

    return weight;
  }
}

double? getHeight() {
  while (true) {
    print('Enter your height in inches: ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid height!');
      continue;
    }

    double? height = double.tryParse(input);
    if (height == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    if (height <= 0 || height > 100) {
      print('❌ Please enter a realistic height (1-100 inches)!');
      continue;
    }

    return height;
  }
}

double calculateBMIScore(double weight, double height) {
  // BMI formula: weight (kg) / (height (m))²
  // Convert inches to meters: 1 inch = 0.0254 meters
  double heightInMeters = height * 0.0254;
  return weight / (heightInMeters * heightInMeters);
}

String getBMICategory(double bmi) {
  if (bmi < 18.5) {
    return 'Underweight 🟡';
  } else if (bmi >= 18.5 && bmi < 25) {
    return 'Normal Weight 🟢';
  } else if (bmi >= 25 && bmi < 30) {
    return 'Overweight 🟠';
  } else {
    return 'Obese 🔴';
  }
}
