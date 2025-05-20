/// This file demonstrates various Set operations in Dart
///
/// Set vs Map:
/// - Set: An unordered collection of unique items
///   * Only stores values (no keys)
///   * Each value must be unique
///   * Perfect for checking existence of items
///   * Great for removing duplicates from collections
///
/// Best Use Cases for Set:
/// 1. Removing duplicates from a list
/// 2. Checking if an item exists in a collection
/// 3. Mathematical set operations (union, intersection, difference)
/// 4. When you need to ensure uniqueness of items
/// 5. When order doesn't matter
///
/// Example scenarios:
/// - Tracking unique visitors to a website
/// - Managing a list of unique tags/categories
/// - Finding common elements between two collections
/// - Maintaining a collection of unique IDs

void main() {
  // 1. Remove an item from a Set
  void removeFromSet() {
    Set<String> fruits = {'apple', 'banana', 'orange', 'mango'};
    print('Original Set: $fruits');

    fruits.remove('banana');
    print('After removing banana: $fruits');
  }

  // 2. Check if a specific item exists in a Set
  void checkItemInSet() {
    Set<int> numbers = {1, 2, 3, 4, 5};
    print('Set: $numbers');

    print('Is 3 in the set? ${numbers.contains(3)}');
    print('Is 6 in the set? ${numbers.contains(6)}');
  }

  // 3. Set operations (Union, Intersection, Difference)
  void setOperations() {
    Set<int> setA = {1, 2, 3, 4, 5};
    Set<int> setB = {4, 5, 6, 7, 8};

    // Union: combines all unique elements from both sets
    print('Union: ${setA.union(setB)}');

    // Intersection: common elements between both sets
    print('Intersection: ${setA.intersection(setB)}');

    // Difference: elements in setA that are not in setB
    print('Difference (A-B): ${setA.difference(setB)}');
  }

  // 4. Convert a Set to a List
  void setToList() {
    Set<String> colors = {'red', 'green', 'blue'};
    print('Original Set: $colors');

    List<String> colorList = colors.toList();
    print('Converted List: $colorList');
  }

  // Run all examples
  print('\n1. Removing from Set:');
  removeFromSet();

  print('\n2. Checking items in Set:');
  checkItemInSet();

  print('\n3. Set Operations:');
  setOperations();

  print('\n4. Converting Set to List:');
  setToList();
}
