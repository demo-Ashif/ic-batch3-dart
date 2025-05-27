/*
  STATIC KEYWORD IN DART
  
  What is Static?
  - Static members belong to the class itself, not to any specific instance
  - They can be accessed without creating an object of the class
  - Static variables are shared among all instances of a class
  - Static methods can only access static variables and other static methods
  
  Why use Static?
  - Memory efficiency: Only one copy exists regardless of how many objects are created
  - Utility functions: Common functionality that doesn't need object state
  - Constants: Class-wide constants that are the same for all instances
  - Counters: Track information across all instances
  
  When to use Static?
  - For utility methods (like Math functions)
  - For constants that belong to the class
  - For counters or shared data
  - For factory methods or singleton patterns
*/

// Example 1: Basic Static Variables and Methods
class Counter {
  // Static variable - shared across all instances
  static int totalCount = 0;

  // Instance variable - unique to each instance
  int instanceCount = 0;

  // Constructor
  Counter() {
    totalCount++; // Increment static counter
    instanceCount++; // Increment instance counter
  }

  // Static method - can only access static members
  static int getTotalCount() {
    return totalCount;
  }

  // Static method with logic
  static void resetTotalCount() {
    totalCount = 0;
    print("Total count has been reset to 0");
  }

  // Instance method - can access both static and instance members
  void displayCounts() {
    print("Instance count: $instanceCount");
    print("Total count: $totalCount");
  }

  // Static method to create and return instance count
  static String getStatistics() {
    return "Total Counter objects created: $totalCount";
  }
}

// Example 2: Static Constants and Utility Class
class MathUtils {
  // Static constants
  static const double PI = 3.14159265359;
  static const double E = 2.71828182846;
  static const int MAX_INT = 9223372036854775807;

  // Private constructor to prevent instantiation
  MathUtils._();

  // Static utility methods
  static double circleArea(double radius) {
    return PI * radius * radius;
  }

  static double circleCircumference(double radius) {
    return 2 * PI * radius;
  }

  static int factorial(int n) {
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  }

  static double power(double base, int exponent) {
    double result = 1;
    for (int i = 0; i < exponent; i++) {
      result *= base;
    }
    return result;
  }

  static bool isPrime(int number) {
    if (number < 2) return false;
    for (int i = 2; i <= number ~/ 2; i++) {
      if (number % i == 0) return false;
    }
    return true;
  }
}

// Example 3: Static in Class Hierarchy
class Student {
  // Static variables
  static int totalStudents = 0;
  static String schoolName = "Dart Programming School";
  static List<String> subjects = ["Math", "Science", "English"];

  // Instance variables
  String name;
  int age;
  late int studentId;

  // Constructor
  Student(this.name, this.age) {
    totalStudents++;
    studentId = totalStudents;
  }

  // Static methods
  static void addSubject(String subject) {
    subjects.add(subject);
    print("Added subject: $subject");
  }

  static void changeSchoolName(String newName) {
    schoolName = newName;
    print("School name changed to: $schoolName");
  }

  static void displaySchoolInfo() {
    print("=== School Information ===");
    print("School: $schoolName");
    print("Total Students: $totalStudents");
    print("Subjects: ${subjects.join(', ')}");
  }

  // Instance method
  void displayStudentInfo() {
    print("Student ID: $studentId");
    print("Name: $name");
    print("Age: $age");
    print("School: $schoolName"); // Accessing static variable
  }
}

// Example 4: Static Factory Methods
class DatabaseConnection {
  // Static variable to hold single instance (Singleton pattern)
  static DatabaseConnection? _instance;

  // Instance variables
  String host;
  int port;
  bool isConnected = false;

  // Private constructor
  DatabaseConnection._internal(this.host, this.port);

  // Static factory method (Singleton pattern)
  static DatabaseConnection getInstance() {
    _instance ??= DatabaseConnection._internal("localhost", 5432);
    return _instance!;
  }

  // Static factory methods for different database types
  static DatabaseConnection mysql({
    String host = "localhost",
    int port = 3306,
  }) {
    return DatabaseConnection._internal(host, port);
  }

  static DatabaseConnection postgresql({
    String host = "localhost",
    int port = 5432,
  }) {
    return DatabaseConnection._internal(host, port);
  }

  static DatabaseConnection mongodb({
    String host = "localhost",
    int port = 27017,
  }) {
    return DatabaseConnection._internal(host, port);
  }

  // Instance methods
  void connect() {
    isConnected = true;
    print("Connected to database at $host:$port");
  }

  void disconnect() {
    isConnected = false;
    print("Disconnected from database");
  }

  void displayStatus() {
    print("Host: $host, Port: $port, Connected: $isConnected");
  }
}

// Example 5: Static with Validation
class ValidationUtils {
  // Static constants for validation
  static const int MIN_PASSWORD_LENGTH = 8;
  static const int MAX_USERNAME_LENGTH = 30;
  static const String EMAIL_PATTERN = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Static method to validate email
  static bool isValidEmail(String email) {
    RegExp regExp = RegExp(EMAIL_PATTERN);
    return regExp.hasMatch(email);
  }

  // Static method to validate password
  static bool isValidPassword(String password) {
    if (password.length < MIN_PASSWORD_LENGTH) {
      print("Password must be at least $MIN_PASSWORD_LENGTH characters");
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    if (!(hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters)) {
      print(
        "Password must contain uppercase, lowercase, digits, and special characters",
      );
      return false;
    }

    return true;
  }

  // Static method to validate username
  static bool isValidUsername(String username) {
    if (username.isEmpty || username.length > MAX_USERNAME_LENGTH) {
      print("Username must be between 1 and $MAX_USERNAME_LENGTH characters");
      return false;
    }

    bool isAlphanumeric = RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username);
    if (!isAlphanumeric) {
      print("Username can only contain letters, numbers, and underscores");
      return false;
    }

    return true;
  }

  // Static method to get validation rules
  static Map<String, String> getValidationRules() {
    return {
      'minPasswordLength': MIN_PASSWORD_LENGTH.toString(),
      'maxUsernameLength': MAX_USERNAME_LENGTH.toString(),
      'emailPattern': EMAIL_PATTERN,
    };
  }
}

// Example 6: Static Variables as Counters
class Book {
  // Static variables
  static int totalBooks = 0;
  static int totalPages = 0;
  static Map<String, int> genreCount = {};

  // Instance variables
  String title;
  String author;
  String genre;
  int pages;
  late int bookId;

  // Constructor
  Book(this.title, this.author, this.genre, this.pages) {
    totalBooks++;
    totalPages += pages;
    bookId = totalBooks;

    // Update genre count
    genreCount[genre] = (genreCount[genre] ?? 0) + 1;
  }

  // Static method to get library statistics
  static void displayLibraryStats() {
    print("=== Library Statistics ===");
    print("Total Books: $totalBooks");
    print("Total Pages: $totalPages");
    print(
      "Average Pages per Book: ${totalPages / (totalBooks > 0 ? totalBooks : 1)}",
    );
    print("Books by Genre:");
    genreCount.forEach((genre, count) {
      print("  $genre: $count books");
    });
  }

  // Static method to find most popular genre
  static String getMostPopularGenre() {
    if (genreCount.isEmpty) return "No books available";

    String mostPopular = "";
    int maxCount = 0;

    genreCount.forEach((genre, count) {
      if (count > maxCount) {
        maxCount = count;
        mostPopular = genre;
      }
    });

    return mostPopular;
  }

  // Instance method
  void displayBookInfo() {
    print("Book #$bookId: $title by $author");
    print("Genre: $genre, Pages: $pages");
  }
}

void main() {
  print("=== STATIC KEYWORD EXAMPLES ===\n");

  // Example 1: Basic Static Usage
  print("1. Basic Static Variables and Methods:");
  print("Initial total count: ${Counter.getTotalCount()}");

  var counter1 = Counter();
  var counter2 = Counter();
  var counter3 = Counter();

  counter1.displayCounts();
  counter2.displayCounts();

  print("Total count after creating 3 counters: ${Counter.getTotalCount()}");
  print(Counter.getStatistics());
  Counter.resetTotalCount();
  print("");

  // Example 2: Static Utility Methods
  print("2. Static Utility Methods:");
  print("PI value: ${MathUtils.PI}");
  print("Circle area (radius 5): ${MathUtils.circleArea(5)}");
  print("Circle circumference (radius 5): ${MathUtils.circleCircumference(5)}");
  print("Factorial of 5: ${MathUtils.factorial(5)}");
  print("2^8 = ${MathUtils.power(2, 8)}");
  print("Is 17 prime? ${MathUtils.isPrime(17)}");
  print("");

  // Example 3: Static in Class Hierarchy
  print("3. Static Class Variables:");
  Student.displaySchoolInfo();

  var student1 = Student("Alice", 20);
  var student2 = Student("Bob", 22);

  student1.displayStudentInfo();
  Student.addSubject("Computer Science");
  Student.changeSchoolName("Advanced Dart Academy");
  Student.displaySchoolInfo();
  print("");

  // Example 4: Static Factory Methods
  print("4. Static Factory Methods:");
  var db1 = DatabaseConnection.getInstance();
  var db2 = DatabaseConnection.getInstance();
  print("Are both instances the same? ${identical(db1, db2)}");

  var mysqlDb = DatabaseConnection.mysql();
  var postgresDb = DatabaseConnection.postgresql();

  mysqlDb.connect();
  mysqlDb.displayStatus();

  postgresDb.connect();
  postgresDb.displayStatus();
  print("");

  // Example 5: Static Validation
  print("5. Static Validation Methods:");
  print("Validation Rules: ${ValidationUtils.getValidationRules()}");

  List<String> emails = [
    "valid@email.com",
    "invalid-email",
    "user@domain.co.uk",
  ];
  for (String email in emails) {
    print("$email is valid: ${ValidationUtils.isValidEmail(email)}");
  }

  List<String> passwords = ["weak", "StrongPass123!", "noSpecial123"];
  for (String password in passwords) {
    print("Password validation for '$password':");
    ValidationUtils.isValidPassword(password);
  }
  print("");

  // Example 6: Static Counters
  print("6. Static as Counters:");
  var book1 = Book("The Dart Guide", "John Doe", "Programming", 350);
  var book2 = Book("Flutter Basics", "Jane Smith", "Programming", 280);
  var book3 = Book("Mystery Novel", "Alice Brown", "Fiction", 420);
  var book4 = Book("Sci-Fi Adventure", "Bob Wilson", "Science Fiction", 380);

  Book.displayLibraryStats();
  print("Most popular genre: ${Book.getMostPopularGenre()}");
}

/*
  KEY POINTS ABOUT STATIC:

  1. Memory: Static members are loaded when the class is first referenced
  2. Access: Use ClassName.staticMember (no object needed)
  3. Inheritance: Static members are inherited but belong to the defining class
  4. No 'this': Static methods cannot use 'this' keyword
  5. Initialization: Static variables are lazily initialized
  
  COMMON USE CASES:
  - Utility classes (Math, String operations)
  - Constants (PI, MAX_VALUE)
  - Counters and statistics
  - Singleton pattern
  - Factory methods
  - Validation methods
  
  BEST PRACTICES:
  - Use static for stateless utility methods
  - Use static constants instead of magic numbers
  - Consider memory implications for static variables
  - Use private constructors for utility classes
  - Document when static state is shared across instances
  
  REMEMBER:
  - Static members belong to the class, not instances
  - Static methods can only access static members directly
  - Static variables are shared across all instances
  - Use static for functionality that doesn't require object state
*/
