# 100DaysOfSwiftUI
## Project 9: Drawing - day 43, 44, 45 and 46
In this technique project we’re going to take a close look at drawing in SwiftUI, including creating custom paths and shapes, animating your changes, solving performance problems, and more – it’s a really big topic, and deserves close attention.

Behind the scenes, SwiftUI uses the same drawing system that we have on the rest of Apple’s frameworks: Core Animation and Metal. Most of the time Core Animation is responsible for our drawing, whether that’s custom paths and shapes or UI elements such as `TextField`, but when things really get complex we can move down to Metal – Apple’s low-level framework that’s optimized for complex drawing. One of the neat features of SwiftUI is that these two are almost interchangeable: we can move from Core Animation to Metal with one small change.

## Challenges
