# 100DaysOfSwiftUI
## Project 5: WordScramble - days 29 to 31
This project will be another game, although really it’s just a sneaky way for me to introduce more Swift and SwiftUI knowledge! The game will show players a random eight-letter word, and ask them to make words out of it. For example, if the starter word is “alarming” they might spell “alarm”, “ring”, “main”, and so on.

Along the way you’ll meet `List`, `onAppear()`, `Bundle`, `fatalError()`, and more – all useful skills that you’ll use for years to come. You’ll also get some practice with `@State`, `Alert`, `NavigationView`, and more, which you should enjoy while you can – this is our last easy project!

## Challenges
1. Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into `isReal()` that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.

2. Add a left bar button item that calls `startGame()`, so users can restart with a new word whenever they want to.

3. Put a text view below the `List` so you can track and show the player’s score for a given root word. How you calculate score is down to you, but something involving number of words and their letter count would be reasonable.
