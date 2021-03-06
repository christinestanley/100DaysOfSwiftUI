//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Chris on 15/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum SortType {
    case name, date
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    @State private var isShowingSort = false
    
    @State private var sortBy: SortType = .name
    
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var sortedProspects: [Prospect] {
        switch sortBy {
        case .name:
            return filteredProspects.sorted(by: { $0.name < $1.name } )
        case .date:
            return filteredProspects.sorted(by: { $0.dateMet > $1.dateMet } )
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if !filteredProspects.isEmpty {
                    Text("[Long press to update contact!]")
                    .font(.headline)
                }
                List {
                    ForEach(sortedProspects) { prospect in
                        VStack(alignment: .leading) {
                            HStack {
                                if self.filter == .none {
                                    if prospect.isContacted {
                                        Image(systemName: "person.crop.circle.badge.checkmark" )
                                            .foregroundColor(.green)
                                        
                                    } else {
                                        Image(systemName: "person.crop.circle.badge.xmark" )
                                            .foregroundColor(.red)
                                    }
                                }
                                Text(prospect.name)
                                    .font(.headline)
                            }
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                            
                        .contextMenu {
                            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                                self.prospects.toggle(prospect)
                            }
                            if !prospect.isContacted {
                                Button("Remind Me") {
                                    self.addNotification(for: prospect)
                                }
                            }
                        }
                    }
                } }
                .navigationBarTitle(title)
                .navigationBarItems(
                    leading: Button(action: {
                        self.isShowingSort = true
                    }) {
                        Image(systemName: "arrow.up.arrow.down.square")
                    },
                    trailing: Button(action: {
                        self.isShowingScanner = true
                    }) {
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scan")
                })
                .actionSheet(isPresented: $isShowingSort) {
                    ActionSheet(title: Text("Sort by"), buttons: [
                        .default(Text("Name")) {self.sortBy = .name},
                        .default(Text("Most Recent")) {self.sortBy = .date}
                    ])
                }
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: self.handleScan)
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]

            self.prospects.add(person)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let testTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: testTrigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh: \(error?.localizedDescription ?? "error")")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
