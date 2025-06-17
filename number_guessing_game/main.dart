import 'dart:io';
import 'dart:math';

void main() {
  print('🎯 Welcome to Number Guessing Game! 🎯');
  print('I\'m thinking of a number between 1 and 100.');

  // Main game loop
  while (true) {
    playGame();

    // Ask if player wants to play again
    print('\nWould you like to play again? (y/n): ');
    String? playAgain = stdin.readLineSync()?.toLowerCase();

    if (playAgain != 'y' && playAgain != 'yes') {
      print('Thanks for playing! 👋');
      break;
    }
  }
}

void playGame() {
  // Generate random number between 1-100
  Random random = Random();
  int secretNumber = random.nextInt(100) + 1;
  int attempts = 0;
  int maxAttempts = 5;

  print('\n--- New Game ---');
  print('You have $maxAttempts attempts to guess the number!');

  // Game loop
  while (attempts < maxAttempts) {
    attempts++;
    int remainingAttempts = maxAttempts - attempts;

    // Get user input
    print('\nAttempt $attempts/$maxAttempts');
    print('Enter your guess (1-100): ');

    String? input = stdin.readLineSync();

    // Input validation
    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid number!');
      continue;
    }

    int? guess = int.tryParse(input);
    if (guess == null) {
      print('❌ Please enter a valid number!');
      continue;
    }

    // Check the guess
    if (guess < 1 || guess > 100) {
      print('❌ Please enter a number between 1 and 100!');
      continue;
    }

    // Compare guess with secret number
    if (guess == secretNumber) {
      print('🎉 Congratulations! You guessed it in $attempts attempts!');
      return;
    } else if (guess < secretNumber) {
      print('📈 Too low! Try a higher number.');
    } else {
      print('📉 Too high! Try a lower number.');
    }

    if (remainingAttempts > 0) {
      print('Attempts remaining: $remainingAttempts');
    }
  }

  // Game over
  print('\n💔 Game Over! You ran out of attempts.');
  print('The number was: $secretNumber');
}
