/*
  DART MIXINS
  
  What are Mixins?
  - A way to reuse code in multiple class hierarchies
  - Allow multiple inheritance of implementation (not just interface)
  - Add functionality to classes without inheritance
  - Defined using 'mixin' keyword
  - Applied using 'with' keyword
  
  Why use Mixins?
  - Share code across unrelated classes
  - Avoid code duplication
  - Compose functionality from multiple sources
  - Solve the "diamond problem" of multiple inheritance
  - Create modular, reusable code
  
  When to use Mixins?
  - When you need functionality in multiple, unrelated classes
  - When inheritance doesn't make sense (no "is-a" relationship)
  - When you want to compose behavior from multiple sources
  - For cross-cutting concerns (logging, validation, etc.)
  
  Key Rules:
  - Mixins cannot have constructors
  - Mixins are applied left-to-right
  - Later mixins override earlier ones
  - Use 'on' keyword to restrict which classes can use the mixin
*/

// Example 1: Basic Mixins
mixin Flyable {
  double altitude = 0;

  void fly() {
    altitude = 1000;
    print("Flying at ${altitude}m altitude");
  }

  void land() {
    altitude = 0;
    print("Landed safely");
  }

  bool get isFlying => altitude > 0;
}

mixin Swimmable {
  double depth = 0;

  void swim() {
    depth = 10;
    print("Swimming at ${depth}m depth");
  }

  void surface() {
    depth = 0;
    print("Surfaced to the top");
  }

  bool get isUnderwater => depth > 0;
}

mixin Walkable {
  double speed = 0;

  void walk() {
    speed = 5;
    print("Walking at ${speed} km/h");
  }

  void run() {
    speed = 15;
    print("Running at ${speed} km/h");
  }

  void stop() {
    speed = 0;
    print("Stopped moving");
  }

  bool get isMoving => speed > 0;
}

// Classes using mixins
class Bird with Flyable, Walkable {
  String name;

  Bird(this.name);

  void showCapabilities() {
    print("$name can:");
    fly();
    walk();
    print("Is flying: $isFlying");
    print("Is moving: $isMoving");
  }
}

class Fish with Swimmable {
  String name;

  Fish(this.name);

  void showCapabilities() {
    print("$name can:");
    swim();
    print("Is underwater: $isUnderwater");
  }
}

class Duck with Flyable, Swimmable, Walkable {
  String name;

  Duck(this.name);

  void showCapabilities() {
    print("$name can do everything:");
    fly();
    swim();
    walk();
    print("Versatile creature!");
  }
}

// Example 2: Mixin with 'on' constraint
abstract class Animal {
  String name;
  Animal(this.name);

  void eat() {
    print("$name is eating");
  }
}

// Mixin that can only be applied to Animal classes
mixin Carnivore on Animal {
  List<String> preyTypes = [];

  void addPrey(String prey) {
    preyTypes.add(prey);
    print("$name now hunts $prey");
  }

  void hunt() {
    if (preyTypes.isEmpty) {
      print("$name has no prey to hunt");
    } else {
      String prey = preyTypes.first;
      print("$name is hunting $prey");
    }
  }

  @override
  void eat() {
    super.eat(); // Call Animal's eat method
    print("$name is eating meat");
  }
}

mixin Herbivore on Animal {
  List<String> plantTypes = [];

  void addPlant(String plant) {
    plantTypes.add(plant);
    print("$name now eats $plant");
  }

  void graze() {
    if (plantTypes.isEmpty) {
      print("$name has no plants to eat");
    } else {
      String plant = plantTypes.first;
      print("$name is grazing on $plant");
    }
  }

  @override
  void eat() {
    super.eat(); // Call Animal's eat method
    print("$name is eating plants");
  }
}

class Lion extends Animal with Carnivore {
  Lion(String name) : super(name);
}

class Rabbit extends Animal with Herbivore {
  Rabbit(String name) : super(name);
}

class Bear extends Animal with Carnivore, Herbivore {
  Bear(String name) : super(name);

  @override
  void eat() {
    super.eat(); // This will call the last mixin's eat method
    print("$name is omnivorous");
  }
}

// Example 3: Mixins for Cross-cutting Concerns
mixin Loggable {
  void log(String message) {
    DateTime now = DateTime.now();
    print("[${now.toString()}] ${this.runtimeType}: $message");
  }

  void logError(String error) {
    log("ERROR: $error");
  }

  void logInfo(String info) {
    log("INFO: $info");
  }
}

mixin Validatable {
  List<String> _errors = [];

  void addError(String error) {
    _errors.add(error);
  }

  void clearErrors() {
    _errors.clear();
  }

  bool get isValid => _errors.isEmpty;

  List<String> get errors => List.unmodifiable(_errors);

  void validate() {
    clearErrors();
    performValidation();
  }

  // Subclasses should override this
  void performValidation() {}
}

mixin Serializable {
  Map<String, dynamic> toJson();

  void fromJson(Map<String, dynamic> json);

  String toJsonString() {
    // In real app, you'd use dart:convert
    Map<String, dynamic> json = toJson();
    return json.toString();
  }
}

// Example 4: Real-world User class with mixins
class User with Loggable, Validatable, Serializable {
  String? name;
  String? email;
  int? age;

  User({this.name, this.email, this.age});

  @override
  void performValidation() {
    logInfo("Validating user data");

    if (name == null || name!.isEmpty) {
      addError("Name is required");
    }

    if (email == null || !email!.contains('@')) {
      addError("Valid email is required");
    }

    if (age == null || age! < 0 || age! > 150) {
      addError("Age must be between 0 and 150");
    }

    if (isValid) {
      logInfo("User validation passed");
    } else {
      logError("User validation failed: ${errors.join(', ')}");
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'age': age};
  }

  @override
  void fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    age = json['age'];
    logInfo("User loaded from JSON");
  }

  void save() {
    validate();
    if (isValid) {
      logInfo("Saving user: $name");
      // Save logic here
    } else {
      logError("Cannot save invalid user");
    }
  }
}

// Example 5: Database Operations Mixin
mixin DatabaseOperations {
  String get tableName;

  void create(Map<String, dynamic> data) {
    print(
      "INSERT INTO $tableName (${data.keys.join(', ')}) VALUES (${data.values.join(', ')})",
    );
  }

  void read(int id) {
    print("SELECT * FROM $tableName WHERE id = $id");
  }

  void update(int id, Map<String, dynamic> data) {
    String setClause = data.entries
        .map((e) => "${e.key} = ${e.value}")
        .join(', ');
    print("UPDATE $tableName SET $setClause WHERE id = $id");
  }

  void delete(int id) {
    print("DELETE FROM $tableName WHERE id = $id");
  }

  void findAll() {
    print("SELECT * FROM $tableName");
  }
}

mixin Timestampable {
  DateTime? createdAt;
  DateTime? updatedAt;

  void setCreatedAt() {
    createdAt = DateTime.now();
  }

  void setUpdatedAt() {
    updatedAt = DateTime.now();
  }

  void initializeTimestamps() {
    DateTime now = DateTime.now();
    createdAt = now;
    updatedAt = now;
  }
}

class Product with DatabaseOperations, Timestampable, Loggable {
  int? id;
  String? name;
  double? price;

  Product({this.id, this.name, this.price}) {
    initializeTimestamps();
    logInfo("Product created");
  }

  @override
  String get tableName => 'products';

  void save() {
    setUpdatedAt();
    if (id == null) {
      create({
        'name': "'$name'",
        'price': price,
        'created_at': "'$createdAt'",
        'updated_at': "'$updatedAt'",
      });
      logInfo("Product saved to database");
    } else {
      update(id!, {
        'name': "'$name'",
        'price': price,
        'updated_at': "'$updatedAt'",
      });
      logInfo("Product updated in database");
    }
  }
}

// Example 6: Mixin Composition and Order
mixin A {
  void method() {
    print("Mixin A");
  }
}

mixin B {
  void method() {
    print("Mixin B");
  }
}

mixin C {
  void method() {
    print("Mixin C");
  }
}

class TestOrder with A, B, C {
  // The last mixin (C) takes precedence
}

// Example 7: Mixin with State Management
mixin StateMixin<T> {
  T? _state;

  T? get state => _state;

  void setState(T newState) {
    T? oldState = _state;
    _state = newState;
    onStateChanged(oldState, newState);
  }

  void onStateChanged(T? oldState, T newState) {
    // Override in classes for custom behavior
  }
}

enum AppState { loading, loaded, error }

class StateManager with StateMixin<AppState>, Loggable {
  StateManager() {
    setState(AppState.loading);
  }

  @override
  void onStateChanged(AppState? oldState, AppState newState) {
    logInfo("State changed from $oldState to $newState");
  }

  void loadData() {
    setState(AppState.loading);
    // Simulate loading
    Future.delayed(Duration(seconds: 1), () {
      setState(AppState.loaded);
    });
  }

  void handleError() {
    setState(AppState.error);
  }
}

void main() {
  print("=== DART MIXIN EXAMPLES ===\n");

  // Example 1: Basic Mixins
  print("1. Basic Mixins:");
  Bird eagle = Bird("Eagle");
  eagle.showCapabilities();
  print("");

  Fish salmon = Fish("Salmon");
  salmon.showCapabilities();
  print("");

  Duck duck = Duck("Duck");
  duck.showCapabilities();
  print("");

  // Example 2: Mixins with 'on' constraint
  print("2. Mixins with 'on' constraint:");
  Lion lion = Lion("Simba");
  lion.addPrey("Zebra");
  lion.addPrey("Antelope");
  lion.hunt();
  lion.eat();
  print("");

  Rabbit rabbit = Rabbit("Bunny");
  rabbit.addPlant("Carrot");
  rabbit.addPlant("Lettuce");
  rabbit.graze();
  rabbit.eat();
  print("");

  Bear bear = Bear("Grizzly");
  bear.addPrey("Fish");
  bear.addPlant("Berries");
  bear.hunt();
  bear.graze();
  bear.eat(); // Shows omnivorous behavior
  print("");

  // Example 3: Cross-cutting Concerns
  print("3. Cross-cutting Concerns:");
  User user1 = User(name: "Alice", email: "alice@example.com", age: 25);
  user1.save();
  print("");

  User user2 = User(name: "", email: "invalid-email", age: -5);
  user2.save();
  print("");

  // Example 4: Serialization
  print("4. Serialization:");
  User user3 = User(name: "Bob", email: "bob@example.com", age: 30);
  user3.validate();
  if (user3.isValid) {
    print("User JSON: ${user3.toJsonString()}");
  }
  print("");

  // Example 5: Database Operations
  print("5. Database Operations:");
  Product product = Product(name: "Laptop", price: 999.99);
  product.save();

  product.id = 1;
  product.name = "Gaming Laptop";
  product.price = 1299.99;
  product.save();

  product.read(1);
  product.findAll();
  product.delete(1);
  print("");

  // Example 6: Mixin Order
  print("6. Mixin Order (last one wins):");
  TestOrder test = TestOrder();
  test.method(); // Will print "Mixin C"
  print("");

  // Example 7: State Management
  print("7. State Management:");
  StateManager manager = StateManager();
  print("Initial state: ${manager.state}");

  manager.loadData();
  print("After loadData: ${manager.state}");

  manager.handleError();
  print("After error: ${manager.state}");
  print("");

  // Demonstrating mixin linearization
  print("8. Mixin Linearization:");
  print("Duck's method resolution order:");
  print("Duck -> Walkable -> Swimmable -> Flyable -> Object");

  Duck duck2 = Duck("Donald");
  print("Duck can fly: ${duck2.isFlying}");
  duck2.fly();
  print("Duck is flying: ${duck2.isFlying}");
  duck2.swim();
  print("Duck is underwater: ${duck2.isUnderwater}");
}

/*
  KEY CONCEPTS OF MIXINS:

  1. LINEARIZATION:
     - Dart creates a linear order for method resolution
     - Order: Class -> Mixin (right to left) -> Superclass -> Object
     - Later mixins override earlier ones
  
  2. MIXIN CONSTRAINTS ('on' keyword):
     - Restrict which classes can use the mixin
     - Ensure mixin has access to specific methods/properties
     - Enable super calls to constraint class methods
  
  3. COMPOSITION OVER INHERITANCE:
     - Mixins enable horizontal code reuse
     - Avoid deep inheritance hierarchies
     - Combine multiple behaviors easily
  
  BEST PRACTICES:

  1. Use mixins for:
     - Cross-cutting concerns (logging, validation)
     - Shared behavior across unrelated classes
     - Composition of functionality
  
  2. Avoid mixins for:
     - Core business logic that defines class identity
     - When simple inheritance would suffice
     - Complex state management (prefer composition)
  
  3. Design guidelines:
     - Keep mixins focused and cohesive
     - Use meaningful names
     - Document mixin dependencies
     - Consider using 'on' constraints when appropriate
  
  COMMON PATTERNS:
  - Cross-cutting concerns (Loggable, Validatable)
  - Capability mixins (Flyable, Swimmable)
  - State management mixins
  - Database operation mixins
  - Serialization mixins
  
  ADVANTAGES:
  - Multiple inheritance of implementation
  - Code reuse across class hierarchies
  - Modular, composable design
  - Avoids code duplication
  
  LIMITATIONS:
  - No constructors in mixins
  - Can make inheritance hierarchy complex
  - Method resolution order can be confusing
  - Potential for diamond problem (resolved by linearization)
  
  REMEMBER:
  - Mixins are applied with 'with' keyword
  - Order matters: rightmost mixin wins conflicts
  - Use 'on' to constrain mixin usage
  - Mixins cannot have constructors
  - Super calls work with mixin constraints
*/
