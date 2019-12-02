# 100DaysOfSwiftUI: Day 65, 66, 67

## Project 13: Instafilter

In this project we’re going to build an app that lets the user import photos from their library, then modify them using various image effects. We’ll cover a number of new techniques, but at the center of it all are one useful app development skill – using Apple’s Core Image framework – and one important SwiftUI skill – integrating with UIKit. There are other things too, but those two are the big takeaways.

Core Image is Apple’s high-performance framework for manipulating images, and it’s extraordinarily powerful. Apple have designed dozens of example image filters for us, providing things like blurs, color shifts, pixellation, and more, and all are optimized to take full advantage of the graphics processing unit (GPU) on iOS devices.

## Challenges

1. Try making the Save button show an error if there was no image in the image view.

2. Make the Change Filter button change its title to show the name of the currently selected filter.

3. Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
