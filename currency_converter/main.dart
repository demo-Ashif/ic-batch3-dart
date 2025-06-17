import 'dart:io';

void main() {
  print('💱 Welcome to Currency Converter! 💱');
  print('Convert between USD, EUR, and BDT (Bangladeshi Taka)');

  // Fixed exchange rates (simulating API data)
  Map<String, double> exchangeRates = {
    'USD_TO_BDT': 110.50, // 1 USD = 110.50 BDT
    'EUR_TO_BDT': 120.30, // 1 EUR = 120.30 BDT
    'BDT_TO_USD': 0.00905, // 1 BDT = 0.00905 USD
    'BDT_TO_EUR': 0.00831, // 1 BDT = 0.00831 EUR
  };

  // Main program loop
  while (true) {
    showMenu();
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        convertCurrency(exchangeRates, 'USD', 'BDT');
        break;
      case '2':
        convertCurrency(exchangeRates, 'EUR', 'BDT');
        break;
      case '3':
        convertCurrency(exchangeRates, 'BDT', 'USD');
        break;
      case '4':
        convertCurrency(exchangeRates, 'BDT', 'EUR');
        break;
      case '5':
        showExchangeRates(exchangeRates);
        break;
      case '6':
        print('👋 Thanks for using Currency Converter!');
        return;
      default:
        print('❌ Invalid choice! Please try again.');
    }
  }
}

void showMenu() {
  print('\n--- Currency Converter Menu ---');
  print('1. USD to BDT');
  print('2. EUR to BDT');
  print('3. BDT to USD');
  print('4. BDT to EUR');
  print('5. Show Exchange Rates');
  print('6. Exit');
  print('Enter your choice (1-6): ');
}

void convertCurrency(
  Map<String, double> rates,
  String fromCurrency,
  String toCurrency,
) {
  print('\n--- $fromCurrency to $toCurrency Conversion ---');

  // Simulate API call
  print('🔄 Fetching latest exchange rates...');
  simulateAPICall();

  // Get amount to convert
  double? amount = getAmount();
  if (amount == null) return;

  // Get conversion rate
  String rateKey = '${fromCurrency}_TO_$toCurrency';
  double? rate = rates[rateKey];

  if (rate == null) {
    print('❌ Conversion rate not available!');
    return;
  }

  // Calculate converted amount
  double convertedAmount = amount * rate;

  // Display result
  print('\n💱 Conversion Result:');
  print('Amount: ${amount.toStringAsFixed(2)} $fromCurrency');
  print('Rate: 1 $fromCurrency = ${rate.toStringAsFixed(4)} $toCurrency');
  print('Result: ${convertedAmount.toStringAsFixed(2)} $toCurrency');
}

double? getAmount() {
  while (true) {
    print('Enter amount to convert: ');
    String? input = stdin.readLineSync();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid amount!');
      continue;
    }

    double? amount = double.tryParse(input);
    if (amount == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    if (amount <= 0) {
      print('❌ Amount must be greater than 0!');
      continue;
    }

    return amount;
  }
}

void showExchangeRates(Map<String, double> rates) {
  print('\n📊 Current Exchange Rates:');
  print('1 USD = ${rates['USD_TO_BDT']!.toStringAsFixed(2)} BDT');
  print('1 EUR = ${rates['EUR_TO_BDT']!.toStringAsFixed(2)} BDT');
  print('1 BDT = ${rates['BDT_TO_USD']!.toStringAsFixed(4)} USD');
  print('1 BDT = ${rates['BDT_TO_EUR']!.toStringAsFixed(4)} EUR');
  print('\n💡 Note: Rates are simulated for demonstration purposes.');
}

void simulateAPICall() {
  // Simulate network delay
  print('⏳ Connecting to exchange rate API...');
  print('✅ Rates updated successfully!');
}
