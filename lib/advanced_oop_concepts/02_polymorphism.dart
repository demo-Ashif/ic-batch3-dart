/*
  DART POLYMORPHISM
  
  What is Polymorphism?
  - Polymorphism means "many forms" - one interface, multiple implementations
  - It allows objects of different classes to be treated as objects of a common base class
  - The same method can behave differently in different classes
  - It's achieved through method overriding and interfaces
  
  Why use Polymorphism?
  - Write more flexible and maintainable code
  - Reduce code duplication
  - Easy to add new types without changing existing code
  - Enables abstraction and encapsulation
  
  Types of Polymorphism in Dart:
  1. Runtime Polymorphism (Method Overriding)
  2. Compile-time Polymorphism (Method Overloading - limited in Dart)
*/

// Example 1: Basic Polymorphism with Animals
abstract class Animal {
  String name;

  Animal(this.name);

  // Abstract method - must be implemented by child classes
  void makeSound();

  // Concrete method - can be used by all animals
  void sleep() {
    print("$name is sleeping... ZZZ");
  }
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void makeSound() {
    print("$name says: Woof! Woof!");
  }
}

class Cat extends Animal {
  Cat(String name) : super(name);

  @override
  void makeSound() {
    print("$name says: Meow! Meow!");
  }
}

class Cow extends Animal {
  Cow(String name) : super(name);

  @override
  void makeSound() {
    print("$name says: Moo! Moo!");
  }
}

// Example 2: Polymorphism with Shapes
abstract class Shape {
  String color;

  Shape(this.color);

  // Abstract methods
  double calculateArea();
  double calculatePerimeter();

  // Concrete method
  void displayInfo() {
    print("Shape Color: $color");
    print("Area: ${calculateArea()}");
    print("Perimeter: ${calculatePerimeter()}");
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
}

class Triangle extends Shape {
  double base;
  double height;
  double side1, side2;

  Triangle(String color, this.base, this.height, this.side1, this.side2)
    : super(color);

  @override
  double calculateArea() {
    return 0.5 * base * height;
  }

  @override
  double calculatePerimeter() {
    return base + side1 + side2;
  }
}

// Example 3: Polymorphism with Vehicles
abstract class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void start();
  void stop();
  void displaySpecs();
}

class Car extends Vehicle {
  int doors;
  String fuelType;

  Car(String brand, int year, this.doors, this.fuelType) : super(brand, year);

  @override
  void start() {
    print("$brand Car: Turn key, engine starts with a purr!");
  }

  @override
  void stop() {
    print("$brand Car: Press brake, engine stops smoothly.");
  }

  @override
  void displaySpecs() {
    print("Car: $brand ($year) - $doors doors, $fuelType fuel");
  }
}

class Motorcycle extends Vehicle {
  int engineCC;

  Motorcycle(String brand, int year, this.engineCC) : super(brand, year);

  @override
  void start() {
    print("$brand Motorcycle: Kick start, engine roars to life!");
  }

  @override
  void stop() {
    print("$brand Motorcycle: Turn off ignition, engine stops.");
  }

  @override
  void displaySpecs() {
    print("Motorcycle: $brand ($year) - ${engineCC}CC engine");
  }
}

class Bicycle extends Vehicle {
  int gears;

  Bicycle(String brand, int year, this.gears) : super(brand, year);

  @override
  void start() {
    print("$brand Bicycle: Start pedaling, wheels begin to turn!");
  }

  @override
  void stop() {
    print("$brand Bicycle: Stop pedaling and use brakes.");
  }

  @override
  void displaySpecs() {
    print("Bicycle: $brand ($year) - $gears gears");
  }
}

// Example 4: Polymorphism with Payment Methods
abstract class PaymentMethod {
  double amount;

  PaymentMethod(this.amount);

  void processPayment();
  bool validatePayment();
  void sendReceipt();
}

class CreditCardPayment extends PaymentMethod {
  String cardNumber;

  CreditCardPayment(double amount, this.cardNumber) : super(amount);

  @override
  void processPayment() {
    print("Processing credit card payment of \$${amount.toStringAsFixed(2)}");
    print("Card: ****${cardNumber.substring(cardNumber.length - 4)}");
  }

  @override
  bool validatePayment() {
    print("Validating credit card...");
    return cardNumber.length == 16; // Simple validation
  }

  @override
  void sendReceipt() {
    print("Credit card receipt sent to email.");
  }
}

class PayPalPayment extends PaymentMethod {
  String email;

  PayPalPayment(double amount, this.email) : super(amount);

  @override
  void processPayment() {
    print("Processing PayPal payment of \$${amount.toStringAsFixed(2)}");
    print("PayPal account: $email");
  }

  @override
  bool validatePayment() {
    print("Validating PayPal account...");
    return email.contains('@'); // Simple validation
  }

  @override
  void sendReceipt() {
    print("PayPal receipt sent to $email.");
  }
}

class CashPayment extends PaymentMethod {
  double cashGiven;

  CashPayment(double amount, this.cashGiven) : super(amount);

  @override
  void processPayment() {
    print("Processing cash payment of \$${amount.toStringAsFixed(2)}");
    if (cashGiven > amount) {
      print("Change: \$${(cashGiven - amount).toStringAsFixed(2)}");
    }
  }

  @override
  bool validatePayment() {
    print("Validating cash payment...");
    return cashGiven >= amount;
  }

  @override
  void sendReceipt() {
    print("Printed paper receipt.");
  }
}

// Utility functions to demonstrate polymorphism
void makeAnimalsSounds(List<Animal> animals) {
  print("=== Making all animals make sounds ===");
  for (Animal animal in animals) {
    animal.makeSound(); // Polymorphic call
    animal.sleep(); // Common method
  }
}

void calculateShapeProperties(List<Shape> shapes) {
  print("=== Calculating properties of all shapes ===");
  for (Shape shape in shapes) {
    shape.displayInfo(); // Polymorphic call
    print("---");
  }
}

void operateVehicles(List<Vehicle> vehicles) {
  print("=== Operating all vehicles ===");
  for (Vehicle vehicle in vehicles) {
    vehicle.displaySpecs(); // Polymorphic call
    vehicle.start(); // Polymorphic call
    vehicle.stop(); // Polymorphic call
    print("---");
  }
}

void processPayments(List<PaymentMethod> payments) {
  print("=== Processing all payments ===");
  for (PaymentMethod payment in payments) {
    if (payment.validatePayment()) {
      // Polymorphic call
      payment.processPayment(); // Polymorphic call
      payment.sendReceipt(); // Polymorphic call
    } else {
      print("Payment validation failed!");
    }
    print("---");
  }
}

void main() {
  print("=== DART POLYMORPHISM EXAMPLES ===\n");

  // Example 1: Animal Polymorphism
  List<Animal> animals = [Dog("Buddy"), Cat("Whiskers"), Cow("Bessie")];
  makeAnimalsSounds(animals);
  print("");

  // Example 2: Shape Polymorphism
  List<Shape> shapes = [
    Circle("Red", 5.0),
    Rectangle("Blue", 10.0, 6.0),
    Triangle("Green", 8.0, 6.0, 5.0, 7.0),
  ];
  calculateShapeProperties(shapes);
  print("");

  // Example 3: Vehicle Polymorphism
  List<Vehicle> vehicles = [
    Car("Toyota", 2023, 4, "Gasoline"),
    Motorcycle("Harley", 2022, 1200),
    Bicycle("Trek", 2021, 21),
  ];
  operateVehicles(vehicles);
  print("");

  // Example 4: Payment Method Polymorphism
  List<PaymentMethod> payments = [
    CreditCardPayment(99.99, "1234567812345678"),
    PayPalPayment(49.99, "user@example.com"),
    CashPayment(25.50, 30.00),
  ];
  processPayments(payments);

  // Demonstrating dynamic type checking
  print("=== Dynamic Type Checking ===");
  Animal mysteryAnimal = Dog("Mystery");

  if (mysteryAnimal is Dog) {
    print("It's a dog!");
  } else if (mysteryAnimal is Cat) {
    print("It's a cat!");
  }

  // Runtime type checking
  print("Mystery animal type: ${mysteryAnimal.runtimeType}");
}

/*
  KEY BENEFITS OF POLYMORPHISM:

  1. Code Reusability: Write code once, use with multiple types
  2. Flexibility: Easy to add new types without changing existing code
  3. Maintainability: Changes in implementation don't affect client code
  4. Abstraction: Hide implementation details behind common interface
  
  REAL-WORLD APPLICATIONS:
  - Plugin systems
  - Game development (different enemy types)
  - UI frameworks (different widget types)
  - Database drivers (different database types)
  - File processing (different file formats)
  
  IMPORTANT CONCEPTS:
  - Late binding: Method to call is determined at runtime
  - Dynamic dispatch: Correct method version is called based on actual object type
  - Interface contracts: All implementing classes must provide required methods
  
  REMEMBER:
  - Polymorphism works with inheritance and interfaces
  - Abstract classes force child classes to implement specific methods
  - Use 'is' operator for runtime type checking
  - Use 'runtimeType' to get the actual type of an object
*/
