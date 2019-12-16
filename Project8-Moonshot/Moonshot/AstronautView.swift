//
//  AstronautView.swift
//  Moonshot
//
//  Created by Chris on 03/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibility(hidden: true)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    List {
                        Section(header: Text("Missions")) {
                            ForEach(self.missions) { mission in
                                Text(mission.displayName)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut

        self.missions = missions.filter({ mission in
            mission.crew.contains(where: {
                $0.name == astronaut.id
            })
        })
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
