//
//  ContentView.swift
//  Instafilter
//
//  Created by Chris on 27/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        var uiImage = inputImage
        
        // from Day 63
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        // inputImage property is often broken so for its safer in general to use .setValue(image, forKey: kCIinputImageKey)
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        if let outputImage = currentFilter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                uiImage = UIImage(cgImage: cgimg)
            }
        }
        
        image = Image(uiImage: uiImage)
        
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: uiImage)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
