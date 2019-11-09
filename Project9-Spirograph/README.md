# 100DaysOfSwiftUI
## Project 9: Spirograph - Day 45
To finish off with something that really goes to town with drawing, I’m going to walk you through creating a simple spirograph with SwiftUI. “Spirograph” is the trademarked name for a toy where you place a pencil inside a circle and spin it around the circumference of another circle, creating various geometric patterns that are known as roulettes – like the casino game.

Our algorithm has four inputs:

- The radius of the inner circle.
- The radius of the outer circle.
- The distance of the virtual pen from the center of the outer circle.
- What amount of the roulette to draw. This is optional, but I think it really helps show what’s happening as the algorithm works.

The parametric equations used here are mathematical standards rather than things I just invented – I literally went to Wikipedia’s page on hypotrochoids (https://en.wikipedia.org/wiki/Hypotrochoid) and converted them to Swift.
