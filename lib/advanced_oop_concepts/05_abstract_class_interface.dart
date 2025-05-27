/*
  DART ABSTRACT CLASSES AND INTERFACES
  
  What are Abstract Classes?
  - Classes that cannot be instantiated directly
  - Can contain both abstract methods (no implementation) and concrete methods (with implementation)
  - Used as base classes for other classes to extend
  - Provide a template/contract for subclasses
  
  What are Interfaces?
  - In Dart, every class implicitly defines an interface
  - Interfaces define what methods a class must implement
  - Use 'implements' keyword to implement an interface
  - A class can implement multiple interfaces
  
  Why use Abstract Classes?
  - Share common code among related classes
  - Force subclasses to implement specific methods
  - Create a consistent API across related classes
  - Reduce code duplication
  
  Why use Interfaces?
  - Define contracts that classes must follow
  - Support multiple inheritance of type
  - Create loosely coupled, flexible designs
  - Enable polymorphism
  
  When to use:
  - Abstract Classes: When you have shared implementation and want to enforce a contract
  - Interfaces: When you need multiple inheritance or just want to define a contract
*/

// Example 1: Basic Abstract Class
abstract class Animal {
  String name;
  int age;

  // Constructor
  Animal(this.name, this.age);

  // Abstract methods - must be implemented by subclasses
  void makeSound();
  void move();

  // Concrete methods - can be used by all subclasses
  void eat() {
    print("$name is eating...");
  }

  void sleep() {
    print("$name is sleeping... ZZZ");
  }

  // Method that uses abstract methods
  void performDailyActivities() {
    print("$name's daily activities:");
    makeSound();
    move();
    eat();
    sleep();
  }
}

class Dog extends Animal {
  String breed;

  Dog(String name, int age, this.breed) : super(name, age);

  @override
  void makeSound() {
    print("$name barks: Woof! Woof!");
  }

  @override
  void move() {
    print("$name runs on four legs");
  }

  // Additional method specific to Dog
  void wagTail() {
    print("$name is wagging tail happily!");
  }
}

class Bird extends Animal {
  bool canFly;

  Bird(String name, int age, this.canFly) : super(name, age);

  @override
  void makeSound() {
    print("$name chirps: Tweet! Tweet!");
  }

  @override
  void move() {
    if (canFly) {
      print("$name flies in the sky");
    } else {
      print("$name walks on the ground");
    }
  }
}

// Example 2: Interface Implementation
// Interface (implicit - every class is an interface)
abstract class Flyable {
  void fly();
  double get maxAltitude;
}

abstract class Swimmable {
  void swim();
  double get maxDepth;
}

abstract class Drivable {
  void drive();
  String get fuelType;
}

// Class implementing multiple interfaces
class Duck extends Animal implements Flyable, Swimmable {
  Duck(String name, int age) : super(name, age);

  @override
  void makeSound() {
    print("$name quacks: Quack! Quack!");
  }

  @override
  void move() {
    print("$name can walk, fly, and swim");
  }

  // Implementing Flyable interface
  @override
  void fly() {
    print("$name is flying low over the water");
  }

  @override
  double get maxAltitude => 1000.0; // meters

  // Implementing Swimmable interface
  @override
  void swim() {
    print("$name is swimming gracefully");
  }

  @override
  double get maxDepth => 5.0; // meters
}

// Example 3: Abstract Class for Shapes
abstract class Shape {
  String color;

  Shape(this.color);

  // Abstract methods
  double calculateArea();
  double calculatePerimeter();

  // Concrete method
  void displayInfo() {
    print("Shape Information:");
    print("Color: $color");
    print("Area: ${calculateArea().toStringAsFixed(2)}");
    print("Perimeter: ${calculatePerimeter().toStringAsFixed(2)}");
  }

  // Abstract getter
  String get shapeType;

  // Template method pattern
  void drawShape() {
    print("Drawing a $color $shapeType");
    print("Area: ${calculateArea().toStringAsFixed(2)} square units");
  }
}

class Circle extends Shape {
  double radius;

  Circle(String color, this.radius) : super(color);

  @override
  double calculateArea() {
    return 3.14159 * radius * radius;
  }

  @override
  double calculatePerimeter() {
    return 2 * 3.14159 * radius;
  }

  @override
  String get shapeType => "Circle";
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(String color, this.width, this.height) : super(color);

  @override
  double calculateArea() {
    return width * height;
  }

  @override
  double calculatePerimeter() {
    return 2 * (width + height);
  }

  @override
  String get shapeType => "Rectangle";
}

// Example 4: Database Interface Pattern
abstract class DatabaseConnection {
  void connect();
  void disconnect();
  void executeQuery(String query);
}

// Interface for specific database operations
abstract class UserRepository {
  Future<Map<String, dynamic>?> findUserById(int id);
  Future<List<Map<String, dynamic>>> findAllUsers();
  Future<bool> createUser(Map<String, dynamic> userData);
  Future<bool> updateUser(int id, Map<String, dynamic> userData);
  Future<bool> deleteUser(int id);
}

// MySQL implementation
class MySQLConnection implements DatabaseConnection, UserRepository {
  String host;
  int port;
  bool _isConnected = false;

  MySQLConnection(this.host, this.port);

  @override
  void connect() {
    print("Connecting to MySQL at $host:$port");
    _isConnected = true;
  }

  @override
  void disconnect() {
    print("Disconnecting from MySQL");
    _isConnected = false;
  }

  @override
  void executeQuery(String query) {
    if (!_isConnected) {
      throw Exception("Not connected to database");
    }
    print("Executing MySQL query: $query");
  }

  @override
  Future<Map<String, dynamic>?> findUserById(int id) async {
    executeQuery("SELECT * FROM users WHERE id = $id");
    // Simulate async operation
    await Future.delayed(Duration(milliseconds: 100));
    return {'id': id, 'name': 'User $id', 'email': 'user$id@example.com'};
  }

  @override
  Future<List<Map<String, dynamic>>> findAllUsers() async {
    executeQuery("SELECT * FROM users");
    await Future.delayed(Duration(milliseconds: 200));
    return [
      {'id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
      {'id': 2, 'name': 'Bob', 'email': 'bob@example.com'},
    ];
  }

  @override
  Future<bool> createUser(Map<String, dynamic> userData) async {
    executeQuery(
      "INSERT INTO users (name, email) VALUES ('${userData['name']}', '${userData['email']}')",
    );
    await Future.delayed(Duration(milliseconds: 150));
    return true;
  }

  @override
  Future<bool> updateUser(int id, Map<String, dynamic> userData) async {
    executeQuery("UPDATE users SET name='${userData['name']}' WHERE id=$id");
    await Future.delayed(Duration(milliseconds: 150));
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    executeQuery("DELETE FROM users WHERE id=$id");
    await Future.delayed(Duration(milliseconds: 100));
    return true;
  }
}

// MongoDB implementation
class MongoDBConnection implements DatabaseConnection, UserRepository {
  String host;
  int port;
  bool _isConnected = false;

  MongoDBConnection(this.host, this.port);

  @override
  void connect() {
    print("Connecting to MongoDB at $host:$port");
    _isConnected = true;
  }

  @override
  void disconnect() {
    print("Disconnecting from MongoDB");
    _isConnected = false;
  }

  @override
  void executeQuery(String query) {
    if (!_isConnected) {
      throw Exception("Not connected to database");
    }
    print("Executing MongoDB operation: $query");
  }

  @override
  Future<Map<String, dynamic>?> findUserById(int id) async {
    executeQuery("db.users.findOne({_id: $id})");
    await Future.delayed(Duration(milliseconds: 100));
    return {'_id': id, 'name': 'User $id', 'email': 'user$id@example.com'};
  }

  @override
  Future<List<Map<String, dynamic>>> findAllUsers() async {
    executeQuery("db.users.find({})");
    await Future.delayed(Duration(milliseconds: 200));
    return [
      {'_id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
      {'_id': 2, 'name': 'Bob', 'email': 'bob@example.com'},
    ];
  }

  @override
  Future<bool> createUser(Map<String, dynamic> userData) async {
    executeQuery(
      "db.users.insertOne({name: '${userData['name']}', email: '${userData['email']}'})",
    );
    await Future.delayed(Duration(milliseconds: 150));
    return true;
  }

  @override
  Future<bool> updateUser(int id, Map<String, dynamic> userData) async {
    executeQuery(
      "db.users.updateOne({_id: $id}, {\$set: {name: '${userData['name']}'}})",
    );
    await Future.delayed(Duration(milliseconds: 150));
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    executeQuery("db.users.deleteOne({_id: $id})");
    await Future.delayed(Duration(milliseconds: 100));
    return true;
  }
}

// Example 5: Plugin System with Interfaces
abstract class Plugin {
  String get name;
  String get version;
  void initialize();
  void execute();
  void cleanup();
}

abstract class ConfigurablePlugin extends Plugin {
  void configure(Map<String, dynamic> config);
}

class LoggingPlugin implements ConfigurablePlugin {
  Map<String, dynamic> _config = {};

  @override
  String get name => "Logger";

  @override
  String get version => "1.0.0";

  @override
  void initialize() {
    print("Initializing Logging Plugin v$version");
  }

  @override
  void execute() {
    String level = _config['level'] ?? 'INFO';
    String message = _config['message'] ?? 'Default log message';
    print("[$level] $message");
  }

  @override
  void cleanup() {
    print("Cleaning up Logging Plugin");
  }

  @override
  void configure(Map<String, dynamic> config) {
    _config = config;
    print("Configured logger with: $config");
  }
}

class EmailPlugin implements ConfigurablePlugin {
  Map<String, dynamic> _config = {};

  @override
  String get name => "Email Sender";

  @override
  String get version => "2.1.0";

  @override
  void initialize() {
    print("Initializing Email Plugin v$version");
  }

  @override
  void execute() {
    String to = _config['to'] ?? 'user@example.com';
    String subject = _config['subject'] ?? 'Default Subject';
    print("Sending email to: $to");
    print("Subject: $subject");
  }

  @override
  void cleanup() {
    print("Cleaning up Email Plugin");
  }

  @override
  void configure(Map<String, dynamic> config) {
    _config = config;
    print("Configured email with: $config");
  }
}

// Plugin Manager
class PluginManager {
  List<Plugin> _plugins = [];

  void addPlugin(Plugin plugin) {
    _plugins.add(plugin);
    plugin.initialize();
  }

  void executePlugin(String name, [Map<String, dynamic>? config]) {
    Plugin? plugin = _plugins.firstWhere(
      (p) => p.name == name,
      orElse: () => throw Exception("Plugin '$name' not found"),
    );

    if (plugin is ConfigurablePlugin && config != null) {
      plugin.configure(config);
    }

    plugin.execute();
  }

  void executeAllPlugins() {
    print("Executing all plugins:");
    for (Plugin plugin in _plugins) {
      print("Executing ${plugin.name}...");
      plugin.execute();
    }
  }

  void cleanup() {
    for (Plugin plugin in _plugins) {
      plugin.cleanup();
    }
    _plugins.clear();
  }
}

void main() async {
  print("=== ABSTRACT CLASSES AND INTERFACES EXAMPLES ===\n");

  // Example 1: Abstract Classes
  print("1. Abstract Classes:");
  Dog dog = Dog("Buddy", 3, "Golden Retriever");
  Bird eagle = Bird("Eagle", 5, true);
  Bird penguin = Bird("Penguin", 2, false);

  dog.performDailyActivities();
  print("");
  eagle.performDailyActivities();
  print("");
  penguin.performDailyActivities();
  dog.wagTail();
  print("");

  // Example 2: Multiple Interface Implementation
  print("2. Multiple Interface Implementation:");
  Duck duck = Duck("Donald", 2);
  duck.performDailyActivities();
  duck.fly();
  duck.swim();
  print("Max flying altitude: ${duck.maxAltitude} meters");
  print("Max swimming depth: ${duck.maxDepth} meters");
  print("");

  // Example 3: Shape Hierarchy
  print("3. Shape Hierarchy:");
  List<Shape> shapes = [
    Circle("Red", 5.0),
    Rectangle("Blue", 10.0, 6.0),
    Circle("Green", 3.0),
  ];

  for (Shape shape in shapes) {
    shape.drawShape();
    shape.displayInfo();
    print("---");
  }

  // Example 4: Database Abstraction
  print("4. Database Abstraction:");

  // Using MySQL
  UserRepository mysqlRepo = MySQLConnection("localhost", 3306);
  (mysqlRepo as DatabaseConnection).connect();

  await mysqlRepo.createUser({'name': 'Alice', 'email': 'alice@test.com'});
  Map<String, dynamic>? user = await mysqlRepo.findUserById(1);
  print("Found user: $user");

  (mysqlRepo as DatabaseConnection).disconnect();
  print("");

  // Using MongoDB
  UserRepository mongoRepo = MongoDBConnection("localhost", 27017);
  (mongoRepo as DatabaseConnection).connect();

  List<Map<String, dynamic>> users = await mongoRepo.findAllUsers();
  print("All users: $users");

  (mongoRepo as DatabaseConnection).disconnect();
  print("");

  // Example 5: Plugin System
  print("5. Plugin System:");
  PluginManager manager = PluginManager();

  manager.addPlugin(LoggingPlugin());
  manager.addPlugin(EmailPlugin());

  manager.executePlugin("Logger", {
    'level': 'ERROR',
    'message': 'Something went wrong!',
  });

  manager.executePlugin("Email Sender", {
    'to': 'admin@example.com',
    'subject': 'System Alert',
  });

  print("\nExecuting all plugins:");
  manager.executeAllPlugins();

  manager.cleanup();

  // Demonstrating polymorphism with interfaces
  print("\n6. Polymorphic Interface Usage:");
  List<UserRepository> repositories = [
    MySQLConnection("mysql-server", 3306),
    MongoDBConnection("mongo-server", 27017),
  ];

  for (UserRepository repo in repositories) {
    print("\nUsing ${repo.runtimeType}:");
    (repo as DatabaseConnection).connect();
    await repo.createUser({'name': 'Test User', 'email': 'test@example.com'});
    (repo as DatabaseConnection).disconnect();
  }
}

/*
  KEY DIFFERENCES:

  ABSTRACT CLASSES:
  - Can have both abstract and concrete methods
  - Can have constructors and instance variables
  - Single inheritance only (extends)
  - Use when you want to share code among closely related classes
  
  INTERFACES:
  - All methods are implicitly abstract (contracts only)
  - Multiple inheritance allowed (implements)
  - Cannot have constructors or instance variables
  - Use when you want to define a contract that unrelated classes can follow
  
  BEST PRACTICES:
  
  1. Abstract Classes:
     - Use for base classes with shared implementation
     - Provide common functionality and enforce contracts
     - Good for template method pattern
  
  2. Interfaces:
     - Use for defining contracts
     - Enable multiple inheritance of type
     - Good for dependency injection and testing
     - Create flexible, loosely coupled designs
  
  COMMON PATTERNS:
  - Template Method Pattern (abstract classes)
  - Strategy Pattern (interfaces)
  - Factory Pattern (abstract factories)
  - Repository Pattern (interfaces for data access)
  - Plugin Architecture (interfaces for extensibility)
  
  REMEMBER:
  - Abstract classes cannot be instantiated
  - Abstract methods must be implemented by concrete subclasses
  - A class can extend one abstract class but implement multiple interfaces
  - Use abstract classes for "is-a" relationships
  - Use interfaces for "can-do" relationships
*/
