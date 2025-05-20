/// This file demonstrates various Map operations in Dart
///
/// Set vs Map:
/// - Map: A collection of key-value pairs
///   * Stores data as key-value pairs
///   * Keys must be unique, values can be duplicated
///   * Perfect for looking up values by their keys
///   * Great for storing related data together
///
/// Best Use Cases for Map:
/// 1. Storing user profiles (username -> user data)
/// 2. Caching data (key -> cached value)
/// 3. Counting occurrences (item -> count)
/// 4. Storing configuration settings
/// 5. When you need to associate data with unique identifiers
///
/// Example scenarios:
/// - User authentication (username -> password)
/// - Product catalog (product ID -> product details)
/// - Language translations (key -> translated text)
/// - API response caching (URL -> response data)
/// - Configuration management (setting name -> value)
/// A Map is a collection of key-value pairs where each key is unique

void main() {
  // 5. Create a Map
  void createMap() {
    // Different ways to create a Map
    Map<String, int> scores1 = {'John': 90, 'Alice': 85, 'Bob': 95};
    Map<String, dynamic> scores2 = {};
    scores2['John'] = 90;
    scores2['Alice'] = 85;

    print('Map 1: $scores1');
    print('Map 2: $scores2');
  }

  // 6. Access an item from a Map
  void accessMapItem() {
    Map<String, String> capitals = {
      'USA': 'Washington D.C.',
      'Japan': 'Tokyo',
      'France': 'Paris',
    };

    print('Capital of USA: ${capitals['USA']}');
    print('Capital of Germany: ${capitals['Germany']}'); // Returns null
  }

  // 7. Add a key-value pair to a Map
  void addToMap() {
    Map<String, int> ages = {'John': 25, 'Alice': 30};
    print('Original Map: $ages');

    ages['Bob'] = 28;
    print('After adding Bob: $ages');
  }

  // 8. Update a key-value pair in a Map
  void updateMap() {
    Map<String, String> colors = {'apple': 'red', 'banana': 'yellow'};
    print('Original Map: $colors');

    colors['apple'] = 'green';
    print('After updating apple: $colors');
  }

  // 9. Remove an item from a Map
  void removeFromMap() {
    Map<String, double> prices = {
      'apple': 1.99,
      'banana': 0.99,
      'orange': 2.49,
    };
    print('Original Map: $prices');

    prices.remove('banana');
    print('After removing banana: $prices');
  }

  // 10. Check if a specific key exists in a Map
  void checkKeyInMap() {
    Map<String, bool> isActive = {'user1': true, 'user2': false};

    print('Is user1 in the map? ${isActive.containsKey('user1')}');
    print('Is user3 in the map? ${isActive.containsKey('user3')}');
  }

  // 11. Loop through a Map
  void loopThroughMap() {
    Map<String, int> scores = {'John': 90, 'Alice': 85, 'Bob': 95};

    print('Using forEach:');
    scores.forEach((name, score) {
      print('$name: $score');
    });

    print('\nUsing for-in:');
    for (var entry in scores.entries) {
      print('${entry.key}: ${entry.value}');
    }
  }

  // 12. Convert keys and values of a Map into separate Lists
  void convertMapToLists() {
    Map<String, int> scores = {'John': 90, 'Alice': 85, 'Bob': 95};

    List<String> names = scores.keys.toList();
    List<int> values = scores.values.toList();

    print('Names: $names');
    print('Scores: $values');
  }

  // Run all examples
  print('\n5. Creating Maps:');
  createMap();

  print('\n6. Accessing Map Items:');
  accessMapItem();

  print('\n7. Adding to Map:');
  addToMap();

  print('\n8. Updating Map:');
  updateMap();

  print('\n9. Removing from Map:');
  removeFromMap();

  print('\n10. Checking Keys in Map:');
  checkKeyInMap();

  print('\n11. Looping through Map:');
  loopThroughMap();

  print('\n12. Converting Map to Lists:');
  convertMapToLists();
}
