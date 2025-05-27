/*
  SUPER KEYWORD IN DART
  
  What is Super Keyword?
  - The 'super' keyword is used to refer to the parent class (superclass)
  - It allows child classes to access parent class methods, properties, and constructors
  - It's essential for inheritance and method overriding
  
  Why do we use Super Keyword?
  - To call parent class constructors
  - To access parent class methods that are overridden
  - To avoid code duplication
  - To extend parent functionality instead of completely replacing it
  
  When to use Super Keyword?
  - When calling parent constructors
  - When overriding methods but want to keep parent functionality
  - When accessing parent class properties or methods
*/

// Example 1: Basic Super with Constructor
class Animal {
  String name;
  int age;

  Animal(this.name, this.age) {
    print("Animal constructor called");
  }

  void makeSound() {
    print("Some animal sound");
  }

  void eat() {
    print("$name is eating");
  }
}

class Dog extends Animal {
  String breed;

  // Using super to call parent constructor
  Dog(String name, int age, this.breed) : super(name, age) {
    print("Dog constructor called");
  }

  // Overriding parent method but extending its functionality
  @override
  void makeSound() {
    super.makeSound(); // Call parent method first
    print("Woof! Woof!"); // Add child-specific behavior
  }

  // Using super to access parent method
  void dogEat() {
    super.eat(); // Call parent's eat method
    print("$name is wagging tail while eating");
  }
}

// Example 2: Super with Method Overriding
class Vehicle {
  String brand;
  int year;

  Vehicle(this.brand, this.year);

  void start() {
    print("$brand vehicle is starting...");
  }

  void displayInfo() {
    print("Brand: $brand, Year: $year");
  }
}

class Car extends Vehicle {
  int doors;

  Car(String brand, int year, this.doors) : super(brand, year);

  @override
  void start() {
    super.start(); // Keep parent functionality
    print("Car engine is warming up...");
    print("Checking systems...");
    print("Ready to drive!");
  }

  @override
  void displayInfo() {
    super.displayInfo(); // Display parent info first
    print("Doors: $doors");
  }
}

// Example 3: Super with Named Constructors
class Shape {
  double width;
  double height;

  Shape(this.width, this.height);

  // Named constructor
  Shape.square(double side) : this(side, side);

  double area() {
    return width * height;
  }

  void showDimensions() {
    print("Width: $width, Height: $height");
  }
}

class Rectangle extends Shape {
  String color;

  Rectangle(double width, double height, this.color) : super(width, height);

  // Named constructor using super
  Rectangle.coloredSquare(double side, this.color) : super.square(side);

  @override
  double area() {
    print("Calculating rectangle area...");
    return super.area(); // Use parent's area calculation
  }

  void displayDetails() {
    super.showDimensions(); // Call parent method
    print("Color: $color");
    print("Area: ${area()}");
  }
}

// Example 4: Multiple Inheritance Levels
class LivingBeing {
  String species;

  LivingBeing(this.species) {
    print("LivingBeing created: $species");
  }

  void breathe() {
    print("$species is breathing");
  }
}

class Mammal extends LivingBeing {
  bool hasFur;

  Mammal(String species, this.hasFur) : super(species) {
    print("Mammal created with fur: $hasFur");
  }

  void giveMilk() {
    print("$species can give milk");
  }
}

class Human extends Mammal {
  String name;

  Human(this.name) : super("Homo sapiens", false) {
    print("Human created: $name");
  }

  @override
  void breathe() {
    super.breathe(); // Call parent's breathe
    print("$name is breathing consciously");
  }

  void speak() {
    print("$name is speaking");
  }

  void showInfo() {
    print("Name: $name");
    print("Species: $species"); // Access grandparent property
    super.giveMilk(); // Call parent method
    breathe(); // This will call overridden method
  }
}

void main() {
  print("=== SUPER KEYWORD EXAMPLES ===\n");

  // Example 1: Basic Super Usage
  print("1. Basic Super with Constructor:");
  var dog = Dog("Buddy", 3, "Golden Retriever");
  dog.makeSound();
  dog.dogEat();
  print("");

  // Example 2: Super with Method Overriding
  print("2. Super with Method Overriding:");
  var car = Car("Toyota", 2023, 4);
  car.start();
  car.displayInfo();
  print("");

  // Example 3: Super with Named Constructors
  print("3. Super with Named Constructors:");
  var rectangle = Rectangle(10, 5, "Blue");
  var square = Rectangle.coloredSquare(8, "Red");

  print("Rectangle details:");
  rectangle.displayDetails();
  print("\nSquare details:");
  square.displayDetails();
  print("");

  // Example 4: Multiple Inheritance Levels
  print("4. Multiple Inheritance Levels:");
  var human = Human("Alice");
  human.showInfo();
}

/*
  KEY POINTS TO REMEMBER:

  1. Constructor Chain: super() must be the first statement in constructor
  2. Method Access: super.methodName() calls parent's version
  3. Property Access: super.propertyName accesses parent's property
  4. Overriding: You can extend parent functionality, not just replace it
  5. Named Constructors: Use super.namedConstructor() for parent named constructors
  
  COMMON MISTAKES:
  - Forgetting to call super() in constructor when parent has required parameters
  - Using super in static methods (not allowed)
  - Calling super() not as the first statement in constructor body
  
  BEST PRACTICES:
  - Always call super() when parent constructor requires parameters
  - Use super to extend functionality, not just replace it
  - Document when and why you're using super for clarity
*/
