// Day 16: 100 Days of Swift UI
  
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

// Support for Xcode preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

// Support for playground preview
let host = UIHostingController(rootView: ContentView())
PlaygroundPage.current.liveView = host
