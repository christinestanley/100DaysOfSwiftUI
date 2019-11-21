# 100DaysOfSwiftUI: Day 57, 58, 59

## Project 12: CoreDataProject
This technique project is going to explore Core Data in more detail, starting with a summary of some basic techniques then building up to tackling some more complex problems.

I combined the example code into a single app using country and ski resort entities.

## Topics Covered

- Why does \.self work for ForEach?

- Creating NSManagedObject subclasses

- Conditional saving of NSManagedObjectContext

- Ensuring Core Data objects are unique using constraints

- Filtering @FetchRequest using NSPredicate

- Dynamically filtering @FetchRequest with SwiftUI

- One-to-many relationships with Core Data, SwiftUI, and @FetchRequest

## Challenges

1. Make it accept an array of `NSSortDescriptor` objects to get used in its fetch request.

2. Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate.

3. Modify the predicate string parameter to be an enum such as `.beginsWith`, then make that enum get resolved to a string inside the initialiser.
