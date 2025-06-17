import 'dart:io';

void main() {
  print('📊 Welcome to Student Grade Calculator! 📊');
  print('Calculate your CGPA using the 4.0 scale');

  // Main program loop
  while (true) {
    calculateCGPA();

    // Ask if user wants to calculate again
    print('\nWould you like to calculate another CGPA? (y/n): ');
    String? continueCalc = stdin.readLineSync()?.toLowerCase();

    if (continueCalc != 'y' && continueCalc != 'yes') {
      print('👋 Thanks for using Grade Calculator!');
      break;
    }
  }
}

void calculateCGPA() {
  print('\n--- CGPA Calculation ---');

  // Get number of courses
  int? numCourses = getNumberOfCourses();
  if (numCourses == null) return;

  // Lists to store course data
  List<String> courseNames = [];
  List<double> gpaValues = [];
  List<int> creditHours = [];

  // Get data for each course
  for (int i = 0; i < numCourses; i++) {
    print('\n--- Course ${i + 1} ---');

    // Get course name
    String? courseName = getCourseName();
    if (courseName == null) return;
    courseNames.add(courseName);

    // Get GPA value
    double? gpa = getGPAValue();
    if (gpa == null) return;
    gpaValues.add(gpa);

    // Get credit hours
    int? credits = getCreditHours();
    if (credits == null) return;
    creditHours.add(credits);
  }

  // Calculate CGPA
  double cgpa = calculateCGPAValue(gpaValues, creditHours);

  // Display results
  displayResults(courseNames, gpaValues, creditHours, cgpa);
}

int? getNumberOfCourses() {
  while (true) {
    print('Enter number of courses: ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid number!');
      continue;
    }

    int? numCourses = int.tryParse(input);
    if (numCourses == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    if (numCourses <= 0 || numCourses > 20) {
      print('❌ Please enter a realistic number (1-20)!');
      continue;
    }

    return numCourses;
  }
}

String? getCourseName() {
  print('Enter course name: ');
  String? courseName = stdin.readLineSync();

  if (courseName == null || courseName.trim().isEmpty) {
    print('❌ Course name cannot be empty!');
    return null;
  }

  return courseName.trim();
}

double? getGPAValue() {
  while (true) {
    print('Enter GPA (0.0 - 4.0): ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid GPA!');
      continue;
    }

    double? gpa = double.tryParse(input);
    if (gpa == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    if (gpa < 0.0 || gpa > 4.0) {
      print('❌ GPA must be between 0.0 and 4.0!');
      continue;
    }

    return gpa;
  }
}

int? getCreditHours() {
  while (true) {
    print('Enter credit hours: ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid number!');
      continue;
    }

    int? credits = int.tryParse(input);
    if (credits == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    if (credits <= 0 || credits > 6) {
      print('❌ Please enter realistic credit hours (1-6)!');
      continue;
    }

    return credits;
  }
}

double calculateCGPAValue(List<double> gpaValues, List<int> creditHours) {
  double totalGradePoints = 0.0;
  int totalCredits = 0;

  // Calculate total grade points and credits
  for (int i = 0; i < gpaValues.length; i++) {
    totalGradePoints += gpaValues[i] * creditHours[i];
    totalCredits += creditHours[i];
  }

  // Calculate CGPA
  return totalGradePoints / totalCredits;
}

void displayResults(
  List<String> courseNames,
  List<double> gpaValues,
  List<int> creditHours,
  double cgpa,
) {
  print('\n📊 CGPA Results:');
  print('=' * 50);

  // Display each course
  for (int i = 0; i < courseNames.length; i++) {
    print(
      '${courseNames[i]}: GPA ${gpaValues[i].toStringAsFixed(2)} (${creditHours[i]} credits)',
    );
  }

  print('=' * 50);
  print('Total Credits: ${creditHours.reduce((a, b) => a + b)}');
  print('CGPA: ${cgpa.toStringAsFixed(2)}');

  // Show academic standing
  String standing = getAcademicStanding(cgpa);
  print('Academic Standing: $standing');
}

String getAcademicStanding(double cgpa) {
  if (cgpa >= 3.7) {
    return 'Excellent 🏆';
  } else if (cgpa >= 3.0) {
    return 'Good 👍';
  } else if (cgpa >= 2.0) {
    return 'Satisfactory ✅';
  } else {
    return 'Needs Improvement ⚠️';
  }
}
