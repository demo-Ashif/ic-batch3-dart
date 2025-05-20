void main() {
  // Example 1: Finding key by value
  void findKeyByValue() {
    Map<String, String> capitals = {
      'USA': 'Washington D.C.',
      'Japan': 'Tokyo',
      'France': 'Paris',
      'Germany': 'Berlin',
      'Italy': 'Rome',
    };

    // Method 1: Using where() to find all keys for a value
    String searchCapital = 'Tokyo';
    List<String> countries =
        capitals.entries
            .where((entry) => entry.value == searchCapital)
            .map((entry) => entry.key)
            .toList();

    print('Countries with capital $searchCapital: $countries');

    // Method 2: Using firstWhere() to find the first matching key
    try {
      String country =
          capitals.entries
              .firstWhere((entry) => entry.value == searchCapital)
              .key;
      print('First country with capital $searchCapital: $country');
    } catch (e) {
      print('No country found with capital $searchCapital');
    }
  }

  // Example 2: Finding value by key
  void findValueByKey() {
    Map<String, int> studentScores = {
      'John': 90,
      'Alice': 85,
      'Bob': 95,
      'Emma': 88,
    };

    // Method 1: Direct access using key
    String studentName = 'Alice';
    int? score = studentScores[studentName];
    print('Score for $studentName: ${score ?? 'Not found'}');

    // Method 2: Using containsKey to check first
    String searchName = 'Mike';
    if (studentScores.containsKey(searchName)) {
      print('Score for $searchName: ${studentScores[searchName]}');
    } else {
      print('$searchName not found in the records');
    }
  }

  // Example 3: Finding multiple values by condition
  void findValuesByCondition() {
    Map<String, int> productPrices = {
      'Laptop': 1200,
      'Phone': 800,
      'Tablet': 500,
      'Headphones': 200,
      'Mouse': 50,
    };

    // Find all products under $600
    Map<String, int> affordableProducts = Map.fromEntries(
      productPrices.entries.where((entry) => entry.value < 600),
    );
    print('Products under \$600: $affordableProducts');

    // Find the most expensive product
    String mostExpensive =
        productPrices.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    print('Most expensive product: $mostExpensive');
  }

  // Example 4: Finding keys with similar values
  void findKeysWithSimilarValues() {
    Map<String, String> userEmails = {
      'john.doe': 'john@example.com',
      'jane.smith': 'jane@example.com',
      'john.smith': 'john@example.com',
      'alice.wong': 'alice@example.com',
    };

    // Find all usernames with the same email
    String searchEmail = 'john@example.com';
    List<String> usernames =
        userEmails.entries
            .where((entry) => entry.value == searchEmail)
            .map((entry) => entry.key)
            .toList();

    print('Usernames with email $searchEmail: $usernames');
  }

  // Run all examples
  print('Example 1: Finding key by value');
  findKeyByValue();

  print('\nExample 2: Finding value by key');
  findValueByKey();

  print('\nExample 3: Finding values by condition');
  findValuesByCondition();

  print('\nExample 4: Finding keys with similar values');
  findKeysWithSimilarValues();
}
