# 100DaysOfSwiftUI: Day 62, 63, 64

## Project 13: InstafilterTechniques

In this project we’re going to build an app that lets the user import photos from their library, then modify them using various image effects. We’ll cover a number of new techniques, but at the center of it all are one useful app development skill – using Apple’s Core Image framework – and one important SwiftUI skill – integrating with UIKit. There are other things too, but those two are the big takeaways.

Core Image is Apple’s high-performance framework for manipulating images, and it’s extraordinarily powerful. Apple have designed dozens of example image filters for us, providing things like blurs, color shifts, pixellation, and more, and all are optimized to take full advantage of the graphics processing unit (GPU) on iOS devices.

## Notes
Added the sepia Core Image Filter to the Coordinator and UIImagePicker example from Day 64. Issues:

1. On a device (iphone SE ios 13.1.3) .onDismiss on .sheet does not get triggered when the ImagePicker returns after an image is selected, but does if the sheet is dismissed using cancel. This did work in the simulator.

2. Portrait images where rotated.
