//
//  EventController.swift
//  ATracker
//
//  Created by Hector on 10/27/19.
//  Copyright © 2019 Hector. All rights reserved.
//

import Cocoa
import EventKit

class EventKitController {
    
    let calendarTitle: String
    let eventStore: EKEventStore
    
    init(calendarTitle: String = "ATaslTracker", eventStore: EKEventStore = EKEventStore()) {
        self.calendarTitle = calendarTitle
        self.eventStore = eventStore
        
    }
    
    func permission() {
        print("jere")
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("Auth")
        case .denied:
            eventStore.requestAccess(to: .event) { _, _ in}
            print("access denied")
//            let openSettingsUrl = openURL(string: NSAttributedString)
//            NSApplication.shared.openURL(openSettingsUrl)
        case .notDetermined:
            eventStore.requestAccess(to: .event) { _, _ in}
            print("access denied")
        default:
            print("Access denied")
        }
    }
    
    func insertEvent(with atrack: ATrack) {
     
        let calendars = eventStore.calendars(for: .event)
        
        print(calendars)
        
        for calendar in calendars {
            print(calendar.title)
            
            if calendar.title == calendarTitle {
                let startDate = atrack.start
                let endDate = atrack.end
                
                let event = EKEvent(eventStore: eventStore)
                event.calendar = calendar
                event.title = atrack.title
                event.startDate = startDate
                event.endDate = endDate
                
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch {
                    NSLog("Error with event: \(error)")
                }
            }
        }
    }
    
    
}
