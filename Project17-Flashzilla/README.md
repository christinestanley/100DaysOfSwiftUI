# 100DaysOfSwiftUI: Day 86 - 90

## Project 17: Flashzilla
In this project we’re going to build an app that helps users learn things using flashcards – cards with one thing written on such as “to buy”, and another thing written on the other side, such as “comprar”. Of course, this is a digital app so we don’t need to worry about “the other side”, and can instead just make the detail for the flash card appear when it’s tapped.

The name for this project is actually the name of my first ever app for iOS – an app I shipped so long ago it was written for iPhoneOS because the iPad hadn’t been announced yet. Apple actually rejected the app during app review because it had “Flash” in its product name, and at the time Apple were really keen to have Flash nowhere near their App Store! How times have changed…

## Challenges: Day 91
1. Make something interesting for when the timer runs out. At the very least make some text appear, but you should also try designing a custom haptic using Core Haptics.

2. Add a settings screen that has a single option: when you get an answer one wrong that card goes back into the array so the user can try it again.

3. If you drag a card to the right but not far enough to remove it, then release, you see it turn red as it slides back to the center. Why does this happen and how can you fix it? (Tip: use a custom modifier for this to avoid cluttering your body property.)
