# Student Grade Calculator 📊

A beginner-friendly Dart console application to calculate CGPA using the 4.0 scale.

## How to Run

```bash
dart run student_grade_calculator/main.dart
```

## Features

- **4.0 CGPA Scale**: Standard academic grading system
- **Multiple Courses**: Calculate CGPA for any number of courses
- **Credit Hours**: Weighted calculation based on credit hours
- **Academic Standing**: Shows performance level with emojis
- **Input Validation**: Ensures realistic GPA and credit values
- **Detailed Results**: Shows breakdown of all courses

## How to Use

1. Enter the number of courses (1-20)
2. For each course, provide:
   - Course name
   - GPA value (0.0 - 4.0)
   - Credit hours (1-6)
3. View your CGPA and academic standing
4. Choose to calculate another CGPA or exit

## Academic Standing

- **3.7 - 4.0**: Excellent 🏆
- **3.0 - 3.69**: Good 👍
- **2.0 - 2.99**: Satisfactory ✅
- **Below 2.0**: Needs Improvement ⚠️

## CGPA Formula

```
CGPA = (Sum of Grade Points × Credit Hours) / Total Credit Hours
```

## Learning Objectives

This project covers:
- **Multiple Lists**: Managing parallel lists for different data types
- **Complex Calculations**: Weighted average calculations
- **List Methods**: Using reduce() for sum calculations
- **Input Validation**: Range checking for academic values
- **Data Organization**: Structuring course information
- **Mathematical Operations**: Grade point calculations
- **String Formatting**: Displaying formatted results

## Key Concepts Demonstrated

1. **Parallel Lists**: Managing related data across multiple lists
2. **Weighted Calculations**: GPA × Credit Hours formula
3. **List Reduction**: Using reduce() method for sums
4. **Data Validation**: Academic value range checking
5. **Complex Functions**: Functions with multiple parameters
6. **Result Formatting**: Professional grade report display
7. **Academic Logic**: Implementing grading standards 