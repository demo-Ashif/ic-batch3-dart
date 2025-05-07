# Dart Control Flow Concepts

This repository contains examples and explanations of various control flow concepts in Dart programming language. These examples are designed for beginners to understand the fundamental concepts of decision-making and loops in Dart.

## Table of Contents

1. [Conditions](#conditions)
   - [if Statement](#if-statement)
   - [if-else Statement](#if-else-statement)
   - [Nested if-else](#nested-if-else)
   - [else-if Ladder](#else-if-ladder)
   - [Ternary Operator](#ternary-operator)
   - [Null-aware Operators](#null-aware-operators)
   - [Switch-Case Statement](#switch-case-statement)

2. [Loops](#loops)
   - [for Loop](#for-loop)
   - [for-in Loop](#for-in-loop)
   - [while Loop](#while-loop)
   - [do-while Loop](#do-while-loop)
   - [break Statement](#break-statement)
   - [continue Statement](#continue-statement)

## Conditions

### if Statement
The `if` statement is the most basic form of decision-making. It executes a block of code only if a specified condition is true.

### if-else Statement
The `if-else` statement provides an alternative block of code to execute when the condition is false.

### Nested if-else
Nested if-else statements allow you to check multiple conditions in a hierarchical manner.

### else-if Ladder
The else-if ladder is used when you need to check multiple conditions in sequence.

### Ternary Operator
A shorthand way to write simple if-else statements in a single line.

### Null-aware Operators
Special operators (`??` and `??=`) to handle null values in a concise way.

### Switch-Case Statement
A cleaner alternative to long if-else ladders when checking a single value against multiple possible values.

## Loops

### for Loop
The traditional loop that executes a block of code a specific number of times.

### for-in Loop
Used to iterate over elements in a collection (like lists, sets, or maps).

### while Loop
Executes a block of code as long as a condition remains true.

### do-while Loop
Similar to while loop, but guarantees at least one execution of the code block.

### break Statement
Used to exit a loop prematurely when a certain condition is met.

### continue Statement
Skips the current iteration of a loop and continues with the next iteration.

## How to Use This Repository

Each concept has its own file in the `lib/control_flow` directory. The examples are written in a way that's easy to understand and follow. Each file contains:
- Clear explanations of the concept
- Simple examples
- Some practical use cases
- Comments explaining the code

## Getting Started

1. Make sure you have Dart installed on your system
2. Clone this repository
3. Navigate to any example file in the `lib/control_flow` directory
4. Run the example using `dart run <filename>`

## Best Practices

1. Always use proper indentation for better readability
2. Keep conditions simple and clear
3. Avoid deeply nested conditions when possible
4. Use appropriate loop types based on your needs
5. Always include comments for complex logic
