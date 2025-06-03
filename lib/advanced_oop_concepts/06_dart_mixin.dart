/*
  DART MIXINS - Beginner Friendly Guide with Key Use Cases

  ✅ What is a Mixin?
  - A mixin is like a reusable bundle of methods and variables.
  - You "mix in" this behavior to any class without inheritance.

  ✅ Why Use Mixins?
  - Share code between multiple classes (like fly, swim, walk).
  - Avoid repeating the same code.
  - Add extra features without making a complex class hierarchy.

  ✅ Syntax
  - Define with: mixin MyMixin {}
  - Apply with: class MyClass with MyMixin {}

  ✅ Rules
  - Mixins cannot have constructors.
  - Mixins are applied left-to-right; later ones override earlier ones.
  - Use 'on' to limit which classes can use the mixin.
*/

/// Basic Mixins
mixin Flyable {
  void fly() {
    print("Flying high!");
  }

  void land() {
    print("Landing safely.");
  }
}

mixin Swimmable {
  void swim() {
    print("Swimming smoothly!");
  }

  void surface() {
    print("Back to the surface.");
  }
}

mixin Walkable {
  void walk() {
    print("Walking around.");
  }

  void run() {
    print("Running fast!");
  }
}

/// Example class using multiple mixins
class Duck with Flyable, Swimmable, Walkable {
  String name;

  Duck(this.name);

  void showAbilities() {
    print("I am $name");
    fly();
    swim();
    walk();
  }
}

/// Example of mixin overriding another mixin
mixin A {
  void speak() {
    print("Mixin A speaking");
  }
}

mixin B {
  void speak() {
    print("Mixin B speaking");
  }
}

class Robot with A, B {
  // B's speak() overrides A's speak()
}

/// ✅ Use Case: Limiting mixin with 'on' keyword
/// This mixin only works on classes that extend `Animal`
class Animal {
  String name;
  Animal(this.name);

  void eat() {
    print("$name is eating");
  }
}

mixin Hunter on Animal {
  void hunt(String prey) {
    print("$name is hunting $prey");
  }

  @override
  void eat() {
    super.eat(); // Call Animal's eat()
    print("$name is eating meat after hunting");
  }
}

class Lion extends Animal with Hunter {
  Lion(String name) : super(name);
}

/// ✅ Best Practice: Use 'on' when your mixin depends on methods or fields
/// from a specific superclass. It makes your code safer and clearer.

void main() {
  print("=== MIXIN BASICS ===");
  Duck duck = Duck("Daffy");
  duck.showAbilities();

  print("\n=== MIXIN OVERRIDE ORDER ===");
  Robot bot = Robot();
  bot.speak(); // Outputs "Mixin B speaking"

  print("\n=== MIXIN WITH 'on' CONSTRAINT ===");
  Lion lion = Lion("Simba");
  lion.hunt("Zebra");
  lion.eat();
}
