# 100DaysOfSwiftUI

## Project 10: Cupcake Corner - day 49, 50, 51 and 52

In this project we’re going to build a multi-screen app for ordering cupcakes. This will use a couple of forms, which are old news for you, but you’re also going to learn how to make classes conform to `Codable` when they have `@Published` properties, how to send and receive data from the internet, how to validate forms, and more.

As we continue to dig deeper and deeper into `Codable`, I hope you’ll continue to be impressed by how flexible and safe it is. In particular, I’d like you to keep in mind how very different it is from the much older `UserDefaults` API – it’s so nice not having to worry about typing strings exactly correctly!

Cupcake images by Brooke Lark / Unsplash.

## Challenges

1. Our address fields are currently considered value if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.

2. If our call to `placeOrder()` fails – for example if there is no internet connection – show an informative alert for the user. To test this, just disable WiFi on your Mac so the simulator has no connection either.

3. For a more challenging task, see if you can convert our data model from a class to a struct, then create an `ObservableObject` class wrapper around it that gets passed around. This will result in your class having one `@Published` property, which is the data struct inside it, and should make supporting `Codable` on the struct much easier.
