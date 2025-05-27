/*
  DART ENUMS (ENUMERATIONS)
  
  What are Enums?
  - Enums are a special type that represents a fixed set of constant values
  - They define a group of named constants that belong together
  - Each enum value is a unique constant within that enum type
  - Enums help make code more readable and prevent invalid values
  
  Why use Enums?
  - Type safety: Prevent invalid values from being used
  - Code readability: Named constants are more meaningful than magic numbers
  - Maintainability: Easy to add/remove options in one place
  - IDE support: Auto-completion and error checking
  - Documentation: Self-documenting code
  
  When to use Enums?
  - Fixed set of options (like days of week, colors, states)
  - Status values (pending, approved, rejected)
  - Categories or types
  - Configuration options
*/

// Example 1: Basic Enum Usage
enum Color { red, green, blue, yellow, purple, orange }

// Example 2: Enhanced Enum with Methods and Properties (Dart 2.17+)
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6),
  mars(6.421e+23, 3.3972e6),
  jupiter(1.9e+27, 7.1492e7),
  saturn(5.688e+26, 6.0268e7),
  uranus(8.686e+25, 2.5559e7),
  neptune(1.024e+26, 2.4746e7);

  // Enum constructor
  const Planet(this.mass, this.radius);

  // Properties
  final double mass; // in kilograms
  final double radius; // in meters

  // Method to calculate surface gravity
  double get surfaceGravity => 6.67300E-11 * mass / (radius * radius);

  // Method to calculate weight on this planet
  double surfaceWeight(double otherMass) => otherMass * surfaceGravity;

  // Static method to get the largest planet
  static Planet getLargestPlanet() {
    return Planet.values.reduce((a, b) => a.radius > b.radius ? a : b);
  }
}

// Example 3: Enum for Application States
enum AppState {
  loading('Loading...', '⏳'),
  loaded('Ready', '✅'),
  error('Error occurred', '❌'),
  offline('No internet', '🔌');

  const AppState(this.message, this.icon);

  final String message;
  final String icon;

  // Method to check if app is ready
  bool get isReady => this == AppState.loaded;

  // Method to check if app has error
  bool get hasError => this == AppState.error || this == AppState.offline;

  // Method to get display text
  String get displayText => '$icon $message';
}

// Example 4: Enum for HTTP Status Codes
enum HttpStatus {
  ok(200, 'OK'),
  created(201, 'Created'),
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  internalServerError(500, 'Internal Server Error');

  const HttpStatus(this.code, this.description);

  final int code;
  final String description;

  // Check if status is successful (2xx)
  bool get isSuccess => code >= 200 && code < 300;

  // Check if status is client error (4xx)
  bool get isClientError => code >= 400 && code < 500;

  // Check if status is server error (5xx)
  bool get isServerError => code >= 500 && code < 600;

  // Get status by code
  static HttpStatus? fromCode(int code) {
    for (HttpStatus status in HttpStatus.values) {
      if (status.code == code) return status;
    }
    return null;
  }

  @override
  String toString() => '$code $description';
}

// Example 5: Enum for User Roles with Permissions
enum UserRole {
  guest(0, ['read']),
  user(1, ['read', 'comment']),
  moderator(2, ['read', 'comment', 'moderate']),
  admin(3, ['read', 'comment', 'moderate', 'delete', 'manage']),
  superAdmin(4, ['all']);

  const UserRole(this.level, this.permissions);

  final int level;
  final List<String> permissions;

  // Check if role has specific permission
  bool hasPermission(String permission) {
    return permissions.contains('all') || permissions.contains(permission);
  }

  // Check if role has higher level than another role
  bool isHigherThan(UserRole other) => level > other.level;

  // Get all roles with level >= specified level
  static List<UserRole> getRolesWithMinLevel(int minLevel) {
    return UserRole.values.where((role) => role.level >= minLevel).toList();
  }
}

// Example 6: Enum for Days of Week with Utilities
enum DayOfWeek {
  monday(1, 'Mon', true),
  tuesday(2, 'Tue', true),
  wednesday(3, 'Wed', true),
  thursday(4, 'Thu', true),
  friday(5, 'Fri', true),
  saturday(6, 'Sat', false),
  sunday(7, 'Sun', false);

  const DayOfWeek(this.number, this.shortName, this.isWeekday);

  final int number;
  final String shortName;
  final bool isWeekday;

  // Get if it's weekend
  bool get isWeekend => !isWeekday;

  // Get next day
  DayOfWeek get nextDay {
    int nextIndex = (index + 1) % DayOfWeek.values.length;
    return DayOfWeek.values[nextIndex];
  }

  // Get previous day
  DayOfWeek get previousDay {
    int prevIndex =
        (index - 1 + DayOfWeek.values.length) % DayOfWeek.values.length;
    return DayOfWeek.values[prevIndex];
  }

  // Get all weekdays
  static List<DayOfWeek> get weekdays =>
      DayOfWeek.values.where((day) => day.isWeekday).toList();

  // Get all weekend days
  static List<DayOfWeek> get weekends =>
      DayOfWeek.values.where((day) => day.isWeekend).toList();
}

// Example 7: Enum for Order Status with State Transitions
enum OrderStatus {
  pending('Pending', ['confirmed', 'cancelled']),
  confirmed('Confirmed', ['processing', 'cancelled']),
  processing('Processing', ['shipped', 'cancelled']),
  shipped('Shipped', ['delivered']),
  delivered('Delivered', []),
  cancelled('Cancelled', []);

  const OrderStatus(this.displayName, this.allowedTransitions);

  final String displayName;
  final List<String> allowedTransitions;

  // Check if transition to another status is allowed
  bool canTransitionTo(OrderStatus newStatus) {
    return allowedTransitions.contains(newStatus.name);
  }

  // Get all possible next statuses
  List<OrderStatus> get possibleNextStatuses {
    return OrderStatus.values
        .where((status) => allowedTransitions.contains(status.name))
        .toList();
  }

  // Check if order is in final state
  bool get isFinalState => allowedTransitions.isEmpty;
}

// Real-world usage examples
class ColorManager {
  static String getHexValue(Color color) {
    switch (color) {
      case Color.red:
        return '#FF0000';
      case Color.green:
        return '#00FF00';
      case Color.blue:
        return '#0000FF';
      case Color.yellow:
        return '#FFFF00';
      case Color.purple:
        return '#800080';
      case Color.orange:
        return '#FFA500';
    }
  }

  static bool isWarmColor(Color color) {
    return [Color.red, Color.yellow, Color.orange].contains(color);
  }
}

class Application {
  AppState _currentState = AppState.loading;

  AppState get currentState => _currentState;

  void setState(AppState newState) {
    print(
      "App state changed: ${_currentState.displayText} → ${newState.displayText}",
    );
    _currentState = newState;
  }

  void performAction() {
    if (_currentState.isReady) {
      print("Performing action...");
    } else if (_currentState.hasError) {
      print("Cannot perform action: ${_currentState.message}");
    } else {
      print("Please wait: ${_currentState.message}");
    }
  }
}

class Order {
  int id;
  OrderStatus status;

  Order(this.id, this.status);

  bool updateStatus(OrderStatus newStatus) {
    if (status.canTransitionTo(newStatus)) {
      print("Order $id: ${status.displayName} → ${newStatus.displayName}");
      status = newStatus;
      return true;
    } else {
      print(
        "Invalid transition: Cannot change from ${status.displayName} to ${newStatus.displayName}",
      );
      return false;
    }
  }

  void showPossibleActions() {
    List<OrderStatus> possible = status.possibleNextStatuses;
    if (possible.isEmpty) {
      print("Order $id is in final state: ${status.displayName}");
    } else {
      print(
        "Order $id can be changed to: ${possible.map((s) => s.displayName).join(', ')}",
      );
    }
  }
}

void main() {
  print("=== DART ENUM EXAMPLES ===\n");

  // Example 1: Basic Enum Usage
  print("1. Basic Enum Usage:");
  Color favoriteColor = Color.blue;
  print("Favorite color: ${favoriteColor.name}");
  print("Color index: ${favoriteColor.index}");
  print("All colors: ${Color.values.map((c) => c.name).join(', ')}");
  print("Hex value: ${ColorManager.getHexValue(favoriteColor)}");
  print("Is warm color? ${ColorManager.isWarmColor(favoriteColor)}");
  print("");

  // Example 2: Enhanced Enum with Properties
  print("2. Enhanced Enum - Planets:");
  Planet earth = Planet.earth;
  print("Planet: ${earth.name}");
  print("Mass: ${earth.mass} kg");
  print("Radius: ${earth.radius} m");
  print("Surface gravity: ${earth.surfaceGravity.toStringAsFixed(2)} m/s²");
  print(
    "Weight of 70kg person: ${earth.surfaceWeight(70).toStringAsFixed(1)} N",
  );
  print("Largest planet: ${Planet.getLargestPlanet().name}");
  print("");

  // Example 3: Application State Management
  print("3. Application State Management:");
  Application app = Application();

  app.performAction(); // Should show loading message
  app.setState(AppState.loaded);
  app.performAction(); // Should perform action
  app.setState(AppState.error);
  app.performAction(); // Should show error
  print("");

  // Example 4: HTTP Status Handling
  print("4. HTTP Status Handling:");
  List<int> statusCodes = [200, 404, 500, 401];
  for (int code in statusCodes) {
    HttpStatus? status = HttpStatus.fromCode(code);
    if (status != null) {
      print("Status $code: ${status.description}");
      print("  Is success: ${status.isSuccess}");
      print("  Is client error: ${status.isClientError}");
      print("  Is server error: ${status.isServerError}");
    }
  }
  print("");

  // Example 5: User Role Permissions
  print("5. User Role Permissions:");
  UserRole currentUser = UserRole.moderator;
  print("Current role: ${currentUser.name} (level ${currentUser.level})");
  print("Permissions: ${currentUser.permissions.join(', ')}");

  List<String> actionsToCheck = ['read', 'comment', 'delete', 'manage'];
  for (String action in actionsToCheck) {
    print("Can $action: ${currentUser.hasPermission(action)}");
  }

  print("Is higher than user: ${currentUser.isHigherThan(UserRole.user)}");
  print(
    "Roles with level >= 2: ${UserRole.getRolesWithMinLevel(2).map((r) => r.name).join(', ')}",
  );
  print("");

  // Example 6: Days of Week
  print("6. Days of Week:");
  DayOfWeek today = DayOfWeek.wednesday;
  print("Today: ${today.name} (${today.shortName})");
  print("Is weekday: ${today.isWeekday}");
  print("Next day: ${today.nextDay.name}");
  print("Previous day: ${today.previousDay.name}");
  print("Weekdays: ${DayOfWeek.weekdays.map((d) => d.shortName).join(', ')}");
  print("Weekends: ${DayOfWeek.weekends.map((d) => d.shortName).join(', ')}");
  print("");

  // Example 7: Order Status Transitions
  print("7. Order Status Transitions:");
  Order order = Order(12345, OrderStatus.pending);

  order.showPossibleActions();
  order.updateStatus(OrderStatus.confirmed);
  order.updateStatus(OrderStatus.processing);
  order.updateStatus(OrderStatus.delivered); // Invalid transition
  order.updateStatus(OrderStatus.shipped);
  order.updateStatus(OrderStatus.delivered);
  order.showPossibleActions();

  // Enum comparison and switch
  print("\n8. Enum in Switch Statements:");
  for (AppState state in AppState.values) {
    String action = switch (state) {
      AppState.loading => "Show loading spinner",
      AppState.loaded => "Display content",
      AppState.error => "Show error message",
      AppState.offline => "Show offline banner",
    };
    print("${state.name}: $action");
  }
}

/*
  KEY FEATURES OF DART ENUMS:

  1. Type Safety: Compile-time checking prevents invalid values
  2. Built-in Properties:
     - .name: String name of the enum value
     - .index: Zero-based index of the enum value
     - .values: List of all enum values
  3. Enhanced Enums (Dart 2.17+):
     - Can have constructors, methods, and properties
     - Can implement interfaces
     - Can have private members
  
  COMMON PATTERNS:
  - State machines (app states, order status)
  - Configuration options
  - Categories and types
  - Constants with behavior
  
  BEST PRACTICES:
  1. Use descriptive names for enum values
  2. Add methods for common operations
  3. Use switch statements for exhaustive handling
  4. Consider adding validation methods
  5. Group related constants together
  
  ADVANTAGES:
  - Prevents typos and invalid values
  - Self-documenting code
  - IDE auto-completion
  - Refactoring safety
  - Easy to extend functionality
  
  REMEMBER:
  - Enum values are compile-time constants
  - Use enhanced enums for complex behavior
  - Switch statements should handle all cases
  - Enum comparison uses identity (==)
*/
