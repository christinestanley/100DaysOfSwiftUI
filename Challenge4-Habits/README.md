# 100DaysOfSwiftUI
## Challenge 4: Habits - Day 47
This time your goal is to build a habit-tracking app, for folks who want to keep track of how much they do certain things. That might be learning a language, practicing an instrument, exercising, or whatever – they get to decide which activities they add, and track it however they want.

At the very least, this means there should be a list of all activities they want to track, plus a form to add new activities – a title and description should be enough.

For a bigger challenge, tapping one of the activities should show a detail screen with the description, how many times they have completed it, plus a button incrementing their completion count.

For an even bigger challenge, use `Codable` and `UserDefaults` to load and save all your data.

So, there are three levels to this app, and you can choose how far you want to go depending on how much time you have and how far you want to push yourself. I do recommend you at least give each level a try, though – every little bit of practice you get helps solidify your learning!

## Hints:

- Start with your data: define a struct that holds a single activity, and a class that can holds an array of activities.

- The class will need to conform to `ObservableObject` and use `@Published` for its property.

- Your main listing and form should both be able to read the shared activities object.

- Make sure your activity conforms to `Identifiable` to avoid problems.

- Present your adding form using `sheet()`, and your activity detail view (if you add one) using `NavigationLink`.

This is genuinely a useful app to build, particularly if it were specialized towards a particular interest – if the goal
were practicing an instrument then you could imagine a more advanced app suggesting different things to practice, or if the goal were exercise then it might suggest new exercises to keep things mixed up.
