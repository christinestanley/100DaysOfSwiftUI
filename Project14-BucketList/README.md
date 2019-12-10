# 100DaysOfSwiftUI: Day 68

## Project 14: Bucket List

In this project we’re going to build an app that lets the user build a private list of places on the map that they intend to visit one day, add a description for that place, look up interesting places that are nearby, and save it all to the iOS storage for later.

To make all that work will mean leveraging some skills you’ve met already, such as forms, sheets, `Codable`, and `URLSession`, but also teach you some new skills: how to embed maps in a SwiftUI app, how to store private data safely so that only an authenticated user can access it, how to load and save data outside of `UserDefaults`, and more.

## Challenges
1. Our + button is rather hard to tap. Try moving all its modifiers to the image inside the button – what difference does it make, and can you think why?

2. Having a complex if condition in the middle of ContentView isn’t easy to read – can you rewrite it so that the MapView, Circle, and Button are part of their own view? This might take more work than you think!

3. Our app silently fails when errors occur during biometric authentication. Add code to show those errors in an alert, but be careful: you can only add one alert() modifier to each view.
