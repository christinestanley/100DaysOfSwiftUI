# 100DaysOfSwiftUI
## Project 4: BetterRest - days 26 to 28
All iPhones come with a technology called Core ML built right in, which allows us to write code that makes predictions about new data based on previous data it has seen. We’ll start with some raw data, give that to our Mac as training data, then use the results to build an app able to make accurate estimates about new data – all on device, and with complete privacy for users.

The actual app we’re build is called BetterRest, and it’s designed to help coffee drinkers get a good night’s sleep by asking them three questions:

1. When do they want to wake up?

2. Roughly how many hours of sleep do they want?

3. How many cups of coffee do they drink per day?

Once we have those three values, we’ll feed them into Core ML to get a result telling us when they ought to go to bed. If you think about it, there are billions of possible answers – all the various wake times multiplied by all the number of sleep hours, multiplied again by the full range of coffee amounts.

That’s where machine learning comes in: using a technique called regression analysis we can ask the computer to come up with an algorithm able to represent all our data. This in turn allows it to apply the algorithm to fresh data it hasn’t seen before, and get accurate results.

## Challenges
1. Replace each `VStack` in our form with a `Section`, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!

2. Replace the “Number of cups” stepper with a `Picker` showing the same range of values.

3. Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.

## Day 76
Fix the steppers in BetterRest so that they read out useful information for VoiceOver when the user adjusts their values.
