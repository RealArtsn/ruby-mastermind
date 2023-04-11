# ruby-mastermind

This is my command-line implementation of the Mastermind project in the Odin Project Ruby course.

A secret four-digit number will be generated and the player must guess the code to win within 12 tries.

The board will show all previous guesses as well as a lowercase `i` to represent a digit that exists in the generated code. If the `I` is uppercase, then one digit of the guess matches its position in the code. The `i` key does not represent any order of the digits, it is up to the player to determine which digits are matching. 