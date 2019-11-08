# 100DaysOfSwiftUI
## Project 8: Moonshot - day 39, 40, 41 and 42
In this project we’re going to build an app that lets users learn about the missions and astronauts that formed NASA’s Apollo space program. You’ll get more experience with `Codable`, but more importantly you’ll also work with scroll views, navigation, and much more interesting layouts.

Yes, you’ll get some practice time with `List`, `Text`, and more, but you’ll also start to solve important SwiftUI problems – how can you make an image fit its space correctly? How can we clean up code using computed properties? How can we compose smaller views into larger ones to help keep our project organized?

From day 41...

Today we’re going to be completing our Moonshot app by adding two more views plus navigation between them, but here is where you’ll start to see what it takes to create custom layouts in SwiftUI – we’ll be using `GeometryReader` to get the view size, `layoutPriority()` to help guide SwiftUI’s layout engine, and more.

Along the way, we’re also going to be tackling one of the common problems you’ll face as programmer: when you two pieces of separate data that need to be merged somehow. For us, that’s our astronaut and mission data, but the concept is transferrable enough as you’ll see.

At one point in today’s topics I encourage you to stop and play around with the design. I’m sure some folks will skip over this wanting to rush towards the end, but I hope you don’t. As the astronaut John Glenn said, “I suppose the quality in an astronaut more powerful than any other is curiosity – they have to get to some place nobody’s ever been.”

## Content
The images of astronauts and mission badges were all created by NASA, so under Title 17, Chapter 1, Section 105 of the US Code they are available for us to use under a public domain license.

Astronauts.json includes a short description that has been copied from Wikipedia. If you intend to use the text in your own shipping projects, it’s important you give credit Wikipedia and its authors and make it clear that the work is licensed under CC-BY-SA available from here: https://creativecommons.org/licenses/by-sa/3.0.

## Challenges
1. Add the launch date to MissionView, below the mission badge.

2. Modify AstronautView to show all the missions this astronaut flew on.

3. Make a bar button in ContentView that toggles between showing launch dates and showing crew names.
