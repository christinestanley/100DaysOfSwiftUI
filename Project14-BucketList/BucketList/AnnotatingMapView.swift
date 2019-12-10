//
//  AnnotatingMapView.swift
//  BucketList
//
//  Created by Chris on 10/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI
import MapKit

struct AnnotatingMapView: View {
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingEditScreen: Bool
    @Binding var annotations: [CodableMKPointAnnotation]
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var showingPlaceDetails = false
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: annotations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width:32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example Location"
                        self.annotations.append(newLocation)
                        
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        }
    }
}

struct AnnotatingMapView_Previews: PreviewProvider {
    static var previews: some View {
        AnnotatingMapView(selectedPlace: .constant(MKPointAnnotation.example), showingEditScreen: .constant(false), annotations: .constant(([MKPointAnnotation.example] as? [CodableMKPointAnnotation])!) )
    }
}
