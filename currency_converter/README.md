# Currency Converter 💱

A beginner-friendly Dart console application to convert between USD, EUR, and BDT (Bangladeshi Taka).

## How to Run

```bash
dart run currency_converter/main.dart
```

## Features

- **Multiple Currencies**: USD, EUR, and BDT support
- **BDT-Based**: All conversions are based on BDT rates
- **API Simulation**: Simulates real API calls for learning
- **Fixed Rates**: Uses realistic exchange rates for demonstration
- **Menu-Driven**: Easy-to-use menu interface
- **Rate Display**: View current exchange rates

## Supported Conversions

- USD to BDT
- EUR to BDT  
- BDT to USD
- BDT to EUR

## How to Use

1. Choose conversion type from menu (1-4)
2. Enter amount to convert
3. View conversion result with rate details
4. Option 5 shows all current exchange rates
5. Option 6 exits the program

## Exchange Rates (Simulated)

- 1 USD = 110.50 BDT
- 1 EUR = 120.30 BDT
- 1 BDT = 0.00905 USD
- 1 BDT = 0.00831 EUR

## Learning Objectives

This project covers:
- **Maps**: Using Map<String, double> for exchange rates
- **String Interpolation**: Dynamic string creation
- **Function Parameters**: Passing multiple parameters
- **Menu Systems**: Complex menu with multiple options
- **API Simulation**: Simulating external service calls
- **Mathematical Operations**: Currency conversion calculations
- **Data Validation**: Input validation for amounts

## Key Concepts Demonstrated

1. **Map Data Structure**: Storing key-value pairs for rates
2. **String Manipulation**: Creating dynamic rate keys
3. **Function Overloading**: Same function with different parameters
4. **Menu Complexity**: Handling multiple menu options
5. **Simulation**: Creating realistic API-like behavior
6. **Mathematical Precision**: Handling decimal calculations
7. **User Experience**: Clear result formatting 